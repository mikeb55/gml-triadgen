// gml-shared-memory.js - RECOVERED
class GMLSharedMemory {
    constructor(appName) {
        this.appName = appName;
        this.storageKey = 'gml_shared_' + appName;
    }
    save(data) {
        try {
            localStorage.setItem(this.storageKey, JSON.stringify(data));
            return true;
        } catch(e) {
            console.error('Memory save error:', e);
            return false;
        }
    }
    load() {
        try {
            const data = localStorage.getItem(this.storageKey);
            return data ? JSON.parse(data) : null;
        } catch(e) {
            console.error('Memory load error:', e);
            return null;
        }
    }
    clear() {
        localStorage.removeItem(this.storageKey);
    }
}
window.GMLSharedMemory = GMLSharedMemory;
