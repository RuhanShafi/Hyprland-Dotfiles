import QtQuick

QtObject {
    id: barConfig
    
    // ========== BAR SETTINGS ==========
    property QtObject bar: QtObject {
        property int height: 45
        property int margin: 5
        property color backgroundColor: "#1e1e2e"
        property color borderColor: "#313244"
        property int borderWidth: 4
        property int borderRadius: 15
    }
    
    // ========== COLOR SCHEME (Catppuccin Mocha) ==========
    property QtObject colors: QtObject {
        property color rosewater: "#f5e0dc"
        property color flamingo: "#f2cdcd"
        property color pink: "#f5c2e7"
        property color mauve: "#cba6f7"
        property color red: "#f38ba8"
        property color maroon: "#eba0ac"
        property color peach: "#fab387"
        property color yellow: "#f9e2af"
        property color green: "#a6e3a1"
        property color teal: "#94e2d5"
        property color sky: "#89dceb"
        property color sapphire: "#74c7ec"
        property color blue: "#89b4fa"
        property color lavender: "#b4befe"
        property color text: "#cdd6f4"
        property color subtext1: "#bac2de"
        property color subtext0: "#a6adc8"
        property color overlay2: "#9399b2"
        property color overlay1: "#7f849c"
        property color overlay0: "#6c7086"
        property color surface2: "#585b70"
        property color surface1: "#45475a"
        property color surface0: "#313244"
        property color base: "#1e1e2e"
        property color mantle: "#181825"
        property color crust: "#11111b"
    }
    
    // ========== WIDGET SETTINGS ==========
    property QtObject widgets: QtObject {
        property int fontSize: 14
        property string fontFamily: "JetBrains Mono Nerd Font"
        property int spacing: 10
        
        // CPU Widget
        property QtObject cpu: QtObject {
            property bool enabled: true
            property color color: barConfig.colors.red
            property string icon: ""
        }
        
        // Memory Widget
        property QtObject memory: QtObject {
            property bool enabled: true
            property color color: barConfig.colors.yellow
            property string icon: ""
        }
        
        // Network Widget
        property QtObject network: QtObject {
            property bool enabled: true
            property color color: barConfig.colors.green
            property string icon: ""
        }
        
        // Clock Widget
        property QtObject clock: QtObject {
            property bool enabled: true
            property color color: barConfig.colors.maroon
            property string icon: ""
            property string timeFormat: "HH:mm"
            property string dateFormat: "dddd d MMM yyyy"
            property bool showDate: true
            property bool showTime: true
        }
        
        // Workspaces Widget
        property QtObject workspaces: QtObject {
            property bool enabled: true
            property color activeColor: barConfig.colors.mauve
            property color inactiveColor: barConfig.colors.surface0
            property int count: 10
            property int dotSize: 12
        }
        
        // Battery Widget
        property QtObject battery: QtObject {
            property bool enabled: true
            property color color: barConfig.colors.green
            property color chargingColor: barConfig.colors.green
            property color lowColor: barConfig.colors.red
            property string icon: ""
            property int lowThreshold: 20
        }
        
        // Volume Widget
        property QtObject volume: QtObject {
            property bool enabled: true
            property color color: barConfig.colors.yellow
            property string icon: ""
        }
        
        // Tray Widget
        property QtObject tray: QtObject {
            property bool enabled: true
            property int iconSize: 16
        }
    }
    
    // ========== LAYOUT SETTINGS ==========
    property QtObject layout: QtObject {
        property var leftWidgets: ["cpu", "memory", "network"]
        property var centerWidgets: ["workspaces"]
        property var rightWidgets: ["volume", "battery", "clock", "tray"]
    }
}
