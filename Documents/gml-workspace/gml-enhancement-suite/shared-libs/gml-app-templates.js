// gml-app-templates.js - RECOVERED
// All genre templates for 8 GML apps

(function(window) {
    'use strict';

    const GMLAppTemplates = {
        // TriadGen Templates
        triadgen: {
            default: { root: 'C', quality: 'major', inversion: 'root', voicing: 'close', octave: '4' },
            jazz: { root: 'F', quality: 'maj7', inversion: 'first', voicing: 'open', octave: '3' },
            classical: { root: 'G', quality: 'major', inversion: 'root', voicing: 'close', octave: '4' },
            rock: { root: 'E', quality: 'power', inversion: 'root', voicing: 'power', octave: '3' },
            pop: { root: 'C', quality: 'add9', inversion: 'root', voicing: 'open', octave: '4' }
        },
        // RiffGen Templates
        riffgen: {
            default: { key: 'C', scale: 'major', length: '8', tempo: '120', noteRange: 'medium' },
            jazz: { key: 'Bb', scale: 'dorian', length: '16', tempo: '140', noteRange: 'wide' },
            classical: { key: 'D', scale: 'natural_minor', length: '16', tempo: '90', noteRange: 'medium' },
            rock: { key: 'E', scale: 'pentatonic_minor', length: '8', tempo: '140', noteRange: 'narrow' },
            blues: { key: 'A', scale: 'blues', length: '12', tempo: '100', noteRange: 'medium' }
        },
        // Drum Engine Templates
        drumengine: {
            default: { pattern: '4/4', tempo: '120', style: 'basic', complexity: 'medium' },
            jazz: { pattern: 'swing', tempo: '130', style: 'jazz', complexity: 'high' },
            rock: { pattern: '4/4', tempo: '140', style: 'rock', complexity: 'medium' },
            funk: { pattern: '16th', tempo: '110', style: 'funk', complexity: 'high' },
            latin: { pattern: 'clave', tempo: '95', style: 'latin', complexity: 'medium' }
        },
        // IRM Templates
        irm: {
            default: { timeSignature: '4/4', tempo: '120', subdivision: '16', swing: '0' },
            jazz: { timeSignature: '4/4', tempo: '140', subdivision: '8t', swing: '65' },
            progressive: { timeSignature: '7/8', tempo: '135', subdivision: '16', swing: '0' },
            electronic: { timeSignature: '4/4', tempo: '128', subdivision: '16', swing: '0' }
        },
        // Quartet Templates
        quartet: {
            default: { key: 'C', tempo: '90', style: 'homophonic', voiceRange: 'satb' },
            classical: { key: 'F', tempo: '72', style: 'fugue', voiceRange: 'satb' },
            jazz: { key: 'Bb', tempo: '120', style: 'swing', voiceRange: 'close' },
            barbershop: { key: 'Eb', tempo: '80', style: 'barbershop', voiceRange: 'ttbb' }
        },
        // SongSketch Templates
        songsketch: {
            default: { structure: 'verse-chorus', key: 'C', tempo: '120', style: 'pop' },
            pop: { structure: 'intro-verse-chorus-verse-chorus-bridge-chorus', key: 'G', tempo: '128', style: 'pop' },
            rock: { structure: 'intro-verse-chorus-solo-chorus', key: 'E', tempo: '140', style: 'rock' },
            folk: { structure: 'verse-chorus-verse', key: 'D', tempo: '95', style: 'folk' }
        },
        // Quintet Templates
        quintet: {
            default: { ensemble: 'strings', key: 'C', tempo: '90', texture: 'homophonic' },
            classical: { ensemble: 'strings', key: 'G', tempo: '80', texture: 'polyphonic' },
            jazz: { ensemble: 'jazz_combo', key: 'F', tempo: '140', texture: 'improvised' },
            brass: { ensemble: 'brass', key: 'Bb', tempo: '120', texture: 'fanfare' }
        },
        // ACE Templates
        ace: {
            default: { root: 'C', quality: 'maj7', extensions: '9', voicing: 'standard' },
            jazz: { root: 'Bb', quality: 'maj7', extensions: '9,11,13', voicing: 'rootless' },
            neosoul: { root: 'Eb', quality: 'min11', extensions: '11', voicing: 'quartal' },
            fusion: { root: 'E', quality: '7', extensions: '9,#11,13', voicing: 'hybrid' }
        }
    };

    window.GMLAppTemplates = GMLAppTemplates;

    window.initializeAppTemplates = function(appName) {
        try {
            const templates = GMLAppTemplates[appName.toLowerCase()];
            if (!templates) {
                console.warn('No templates for app: ' + appName);
                return new window.GMLTemplateSystem(appName, { default: {} });
            }
            return new window.GMLTemplateSystem(appName, templates);
        } catch(error) {
            console.error('Error initializing:', error);
            return null;
        }
    };
})(window);
