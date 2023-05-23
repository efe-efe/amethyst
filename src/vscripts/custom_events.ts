interface CustomEventListener {
    eventName: string;
    callback: any;
}

export class CustomEvents {
    private static instance: CustomEvents;
    private listeners: CustomEventListener[] = [];

    private constructor() {
        //
    }

    public static GetInstance(): CustomEvents {
        if (!CustomEvents.instance) {
            CustomEvents.instance = new CustomEvents();
        }

        return CustomEvents.instance;
    }

    RegisterListener(eventName: string, callback: any): void {
        this.listeners.push({
            eventName,
            callback
        });
    }

    EmitEvent(eventName: string, event: any): void {
        const listeners = this.listeners.filter(listener => listener.eventName === eventName);
        listeners.forEach(listener => {
            listener.callback(event);
        });
    }
}
