//Adds a listener to the message event
//This is the main message pump for the PostMessage API for the WebWorker,
//this deals with all the different message types that the worker/host can use
//to communicate
self.addEventListener('message', function (e) {
    var data = e.data;
    var state = 'stopped';

    switch (data.cmd) {
        case 'play':
            state = 'playing';
            break;
        case 'stop':
            state = 'stopped';
            break;
        case 'state':
            self.postMessage(state);
        case 'quit':
            self.close(); // Terminates the worker.
        default:
            self.postMessage('Unknown command: ' + data.msg);
    };
}, false);