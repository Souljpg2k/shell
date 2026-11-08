import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland

Scope {
    id: root
    readonly property int corner: 25

    Variants {
        model: Quickshell.screens

        Instantiator {
            id: inst
            required property var modelData
            model: 4

            delegate: PanelWindow {
                id: w
                required property int index
                readonly property bool left: index % 2 === 0
                readonly property bool bottom: index > 1

                screen: inst.modelData

                anchors {
                    top: !bottom
                    bottom: bottom
                    left: left
                    right: !left
                }

                implicitWidth: root.corner
                implicitHeight: root.corner

                exclusionMode: ExclusionMode.Ignore
                WlrLayershell.layer: WlrLayer.Overlay
                mask: Region {}

                color: "transparent"

                Shape {
                    anchors.fill: parent
                    preferredRendererType: Shape.CurveRenderer

                    ShapePath {
                        fillColor: "black"
                        strokeColor: "transparent"

                        startX: w.left ? 0 : root.corner
                        startY: w.bottom ? root.corner : 0

                        PathLine {
                            x: w.left ? root.corner : 0
                            y: w.bottom ? root.corner : 0
                        }

                        PathQuad {
                            x: w.left ? 0 : root.corner
                            y: w.bottom ? 0 : root.corner

                            controlX: w.left ? 0 : root.corner
                            controlY: w.bottom ? root.corner : 0
                        }
                    }
                }
            }
        }
    }
}
