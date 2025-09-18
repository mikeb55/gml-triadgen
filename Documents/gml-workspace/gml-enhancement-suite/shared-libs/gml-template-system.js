// gml-template-system.js - BULLETPROOF Version
(function(window) {
    'use strict';
    
    class GMLTemplateSystem {
        constructor(appName, templates) {
            try {
                this.appName = appName || 'unknown';
                this.templates = templates || { default: {} };
                this.currentTemplate = 'default';
                this.customPresets = this.loadCustomPresets();
                this.initialized = false;
                
                if (document.readyState === 'loading') {
                    document.addEventListener('DOMContentLoaded', () => {
                        this.initializeUI();
                    });
                } else {
                    this.initializeUI();
                }
            } catch (error) {
                console.error('[GMLTemplateSystem] Constructor error:', error);
            }
        }
        
        loadCustomPresets() {
            const key = 'gml_' + this.appName + '_custom_presets';
            try {
                const stored = localStorage.getItem(key);
                if (!stored) return {};
                const parsed = JSON.parse(stored);
                return (typeof parsed === 'object' && parsed !== null) ? parsed : {};
            } catch (e) {
                console.warn('[GMLTemplateSystem] Error loading presets:', e);
                return {};
            }
        }
        
        saveCustomPreset(name, settings) {
            try {
                if (!name || typeof name !== 'string') {
                    throw new Error('Invalid preset name');
                }
                this.customPresets[name] = {
                    ...settings,
                    created: new Date().toISOString()
                };
                const key = 'gml_' + this.appName + '_custom_presets';
                localStorage.setItem(key, JSON.stringify(this.customPresets));
                this.updateTemplateSelector();
                return true;
            } catch (error) {
                console.error('[GMLTemplateSystem] Error saving preset:', error);
                return false;
            }
        }
        
        deleteCustomPreset(name) {
            try {
                if (this.customPresets[name]) {
                    delete this.customPresets[name];
                    const key = 'gml_' + this.appName + '_custom_presets';
                    localStorage.setItem(key, JSON.stringify(this.customPresets));
                    this.updateTemplateSelector();
                    return true;
                }
                return false;
            } catch (error) {
                console.error('[GMLTemplateSystem] Error deleting preset:', error);
                return false;
            }
        }
        
        getAllTemplates() {
            try {
                return {
                    ...this.templates,
                    ...this.customPresets
                };
            } catch (error) {
                return this.templates || { default: {} };
            }
        }
        
        applyTemplate(templateName) {
            try {
                const allTemplates = this.getAllTemplates();
                const template = allTemplates[templateName];
                
                if (!template) {
                    console.warn('[GMLTemplateSystem] Template not found: ' + templateName);
                    return false;
                }
                
                this.currentTemplate = templateName;
                
                Object.entries(template).forEach(([key, value]) => {
                    try {
                        if (key === 'created' || key === 'timestamp') return;
                        
                        const element = document.getElementById(key) || 
                                       document.querySelector('[name="' + key + '"]');
                        
                        if (element) {
                            if (element.type === 'checkbox') {
                                element.checked = !!value;
                            } else if (element.tagName === 'SELECT') {
                                element.value = value;
                            } else {
                                element.value = value;
                            }
                        }
                    } catch (fieldError) {
                        console.warn('Error setting field ' + key + ':', fieldError);
                    }
                });
                
                this.showNotification('Applied "' + templateName + '" template');
                return true;
                
            } catch (error) {
                console.error('[GMLTemplateSystem] Error applying template:', error);
                return false;
            }
        }
        
        getCurrentSettings() {
            const settings = {};
            try {
                const inputs = document.querySelectorAll('input, select, textarea');
                inputs.forEach(input => {
                    const key = input.id || input.name;
                    if (key) {
                        if (input.type === 'checkbox') {
                            settings[key] = input.checked;
                        } else {
                            settings[key] = input.value;
                        }
                    }
                });
            } catch (error) {
                console.error('[GMLTemplateSystem] Error getting settings:', error);
            }
            return settings;
        }
        
        initializeUI() {
            try {
                if (this.initialized) return;
                this.initialized = true;
                console.log('[GMLTemplateSystem] UI Initialized');
            } catch (error) {
                console.error('[GMLTemplateSystem] Error initializing UI:', error);
            }
        }
        
        updateTemplateSelector() {
            console.log('[GMLTemplateSystem] Selector updated');
        }
        
        showNotification(message, type = 'success') {
            console.log('[GMLTemplateSystem] ' + message);
        }
    }
    
    window.GMLTemplateSystem = GMLTemplateSystem;
    
})(window);
