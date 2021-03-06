﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading;
using Umbraco.Core.Logging;
using Umbraco.Core.PropertyEditors;
using umbraco.interfaces;

namespace Umbraco.Core
{

	/// <summary>
	/// Used to resolve all plugin types and cache them and is also used to instantiate plugin types
	/// </summary>
	/// <remarks>
	/// 
	/// This class should be used to resolve all plugin types, the TypeFinder should not be used directly!
	/// 
	/// This class can expose extension methods to resolve custom plugins
	/// 
	/// </remarks>
	internal class PluginManager
	{

		internal PluginManager()
		{
		}

		static PluginManager _resolver;
		static readonly ReaderWriterLockSlim Lock = new ReaderWriterLockSlim();

		/// <summary>
		/// We will ensure that no matter what, only one of these is created, this is to ensure that caching always takes place
		/// </summary>
		/// <remarks>
		/// The setter is generally only used for unit tests
		/// </remarks>
		internal static PluginManager Current
		{
			get
			{
				using (var l = new UpgradeableReadLock(Lock))
				{
					if (_resolver == null)
					{
						l.UpgradeToWriteLock();
						_resolver = new PluginManager();
					}
					return _resolver;
				}
			}
			set { _resolver = value; }
		}

		private readonly ReaderWriterLockSlim _lock = new ReaderWriterLockSlim();
		private readonly HashSet<TypeList> _types = new HashSet<TypeList>();
		private IEnumerable<Assembly> _assemblies;

		/// <summary>
		/// Returns all classes attributed with XsltExtensionAttribute attribute
		/// </summary>
		/// <returns></returns>
		internal IEnumerable<Type> ResolveCacheRefreshers()
		{
			return ResolveTypes<ICacheRefresher>();
		}

		/// <summary>
		/// Returns all available IPropertyEditorValueConverter
		/// </summary>
		/// <returns></returns>
		internal IEnumerable<Type> ResolvePropertyEditorValueConverters()
		{
			return ResolveTypes<IPropertyEditorValueConverter>();
		} 

		/// <summary>
		/// Returns all available IDataType in application
		/// </summary>
		/// <returns></returns>
		internal IEnumerable<Type> ResolveDataTypes()
		{
			return ResolveTypes<IDataType>();
		}

		/// <summary>
		/// Returns all available IMacroGuiRendering in application
		/// </summary>
		/// <returns></returns>
		internal IEnumerable<Type> ResolveMacroRenderings()
		{
			return ResolveTypes<IMacroGuiRendering>();
		}

		/// <summary>
		/// Returns all available IPackageAction in application
		/// </summary>
		/// <returns></returns>
		internal IEnumerable<Type> ResolvePackageActions()
		{
			return ResolveTypes<IPackageAction>();
		}

		/// <summary>
		/// Returns all available IAction in application
		/// </summary>
		/// <returns></returns>
		internal IEnumerable<Type> ResolveActions()
		{
			return ResolveTypes<IAction>();
		}

		/// <summary>
		/// Gets/sets which assemblies to scan when type finding, generally used for unit testing, if not explicitly set
		/// this will search all assemblies known to have plugins and exclude ones known to not have them.
		/// </summary>
		internal IEnumerable<Assembly> AssembliesToScan
		{
			get { return _assemblies ?? (_assemblies = TypeFinder.GetAssembliesWithKnownExclusions()); }
			set { _assemblies = value; }
		}

		/// <summary>
		/// Used to resolve and create instances of the specified type based on the resolved/cached plugin types
		/// </summary>
		/// <typeparam name="T"></typeparam>
		/// <param name="throwException">set to true if an exception is to be thrown if there is an error during instantiation</param>
		/// <returns></returns>
		internal IEnumerable<T> FindAndCreateInstances<T>(bool throwException = false)
		{
			var types = ResolveTypes<T>();
			return CreateInstances<T>(types, throwException);
		}

		/// <summary>
		/// Used to create instances of the specified type based on the resolved/cached plugin types
		/// </summary>
		/// <typeparam name="T"></typeparam>
		/// <param name="types"></param>
		/// <param name="throwException">set to true if an exception is to be thrown if there is an error during instantiation</param>
		/// <returns></returns>
		internal IEnumerable<T> CreateInstances<T>(IEnumerable<Type> types, bool throwException = false)
		{
			//Have removed logging because it doesn't really need to be logged since the time taken is generally 0ms.
			//we want to know if it fails ever, not how long it took if it is only 0.

			var typesAsArray = types.ToArray();
			//using (DisposableTimer.DebugDuration<PluginManager>(
			//	String.Format("Starting instantiation of {0} objects of type {1}", typesAsArray.Length, typeof(T).FullName),
			//	String.Format("Completed instantiation of {0} objects of type {1}", typesAsArray.Length, typeof(T).FullName)))
			//{
				var instances = new List<T>();
				foreach (var t in typesAsArray)
				{
					try
					{
						var typeInstance = (T)Activator.CreateInstance(t);
						instances.Add(typeInstance);
					}
					catch (Exception ex)
					{

						LogHelper.Error<PluginManager>(String.Format("Error creating type {0}", t.FullName), ex);

						if (throwException)
						{
							throw ex;
						}
					}
				}
				return instances;
			//}
		}

		/// <summary>
		/// Used to create an instance of the specified type based on the resolved/cached plugin types
		/// </summary>
		/// <typeparam name="T"></typeparam>
		/// <param name="type"></param>
		/// <param name="throwException"></param>
		/// <returns></returns>
		internal T CreateInstance<T>(Type type, bool throwException = false)
		{
			var instances = CreateInstances<T>(new[] { type }, throwException);
			return instances.FirstOrDefault();
		}

		private IEnumerable<Type> ResolveTypes<T>(
			Func<IEnumerable<Type>> finder, 
			TypeResolutionKind resolutionType,
			bool cacheResult)
		{
			using (var readLock = new UpgradeableReadLock(_lock))
			{
				using (DisposableTimer.TraceDuration<PluginManager>(
					String.Format("Starting resolution types of {0}", typeof(T).FullName),
					String.Format("Completed resolution of types of {0}", typeof(T).FullName)))
				{
					//check if the TypeList already exists, if so return it, if not we'll create it
					var typeList = _types.SingleOrDefault(x => x.IsTypeList<T>(resolutionType));
					//if we're not caching the result then proceed, or if the type list doesn't exist then proceed
					if (!cacheResult || typeList == null)
					{
						//upgrade to a write lock since we're adding to the collection
						readLock.UpgradeToWriteLock();

						typeList = new TypeList<T>(resolutionType);

						foreach (var t in finder())
						{
							typeList.AddType(t);
						}

						//only add the cache if we are to cache the results
						if (cacheResult)
						{
							//add the type list to the collection
							_types.Add(typeList);	
						}						
					}
					return typeList.GetTypes();
				}
			}
		}

		/// <summary>
		/// Generic method to find the specified type and cache the result
		/// </summary>
		/// <typeparam name="T"></typeparam>
		/// <returns></returns>
		internal IEnumerable<Type> ResolveTypes<T>(bool cacheResult = true)
		{
			return ResolveTypes<T>(
				() => TypeFinder.FindClassesOfType<T>(AssembliesToScan), 
				TypeResolutionKind.FindAllTypes,
				cacheResult);
		}

		/// <summary>
		/// Generic method to find the specified type that has an attribute and cache the result
		/// </summary>
		/// <typeparam name="T"></typeparam>
		/// <typeparam name="TAttribute"></typeparam>
		/// <returns></returns>
		internal IEnumerable<Type> ResolveTypesWithAttribute<T, TAttribute>(bool cacheResult = true)
			where TAttribute : Attribute
		{
			return ResolveTypes<T>(
				() => TypeFinder.FindClassesOfTypeWithAttribute<T, TAttribute>(AssembliesToScan),
				TypeResolutionKind.FindTypesWithAttribute,
				cacheResult);
		}

		/// <summary>
		/// Generic method to find any type that has the specified attribute
		/// </summary>
		/// <typeparam name="TAttribute"></typeparam>
		/// <returns></returns>
		internal IEnumerable<Type> ResolveAttributedTypes<TAttribute>(bool cacheResult = true)
			where TAttribute : Attribute
		{
			return ResolveTypes<TAttribute>(
				() => TypeFinder.FindClassesWithAttribute<TAttribute>(AssembliesToScan),
				TypeResolutionKind.FindAttributedTypes,
				cacheResult);
		}

		/// <summary>
		/// Used for unit tests
		/// </summary>
		/// <returns></returns>
		internal HashSet<TypeList> GetTypeLists()
		{
			return _types;
		}



		#region Private classes/Enums

		/// <summary>
		/// The type of resolution being invoked
		/// </summary>
		internal enum TypeResolutionKind
		{
			FindAllTypes,
			FindAttributedTypes,
			FindTypesWithAttribute
		}

		internal abstract class TypeList
		{
			public abstract void AddType(Type t);
			public abstract bool IsTypeList<TLookup>(TypeResolutionKind resolutionType);
			public abstract IEnumerable<Type> GetTypes();
		}

		internal class TypeList<T> : TypeList
		{
			private readonly TypeResolutionKind _resolutionType;

			public TypeList(TypeResolutionKind resolutionType)
			{
				_resolutionType = resolutionType;
			}

			private readonly List<Type> _types = new List<Type>();

			public override void AddType(Type t)
			{
				//if the type is an attribute type we won't do the type check because typeof<T> is going to be the 
				//attribute type whereas the 't' type is the object type found with the attribute.
				if (_resolutionType == TypeResolutionKind.FindAttributedTypes || t.IsType<T>())
				{
					_types.Add(t);
				}
			}

			/// <summary>
			/// Returns true if the current TypeList is of the same type and of the same type
			/// </summary>
			/// <typeparam name="TLookup"></typeparam>
			/// <param name="resolutionType"></param>
			/// <returns></returns>
			public override bool IsTypeList<TLookup>(TypeResolutionKind resolutionType)
			{
				return _resolutionType == resolutionType && (typeof (T)).IsType<TLookup>();
			}

			public override IEnumerable<Type> GetTypes()
			{
				return _types;
			}
		}
		#endregion
	}
}
