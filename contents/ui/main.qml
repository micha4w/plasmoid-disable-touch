/*
    SPDX-FileCopyrightText: 2014 Ashish Madeti <ashishmadeti@gmail.com>
    SPDX-FileCopyrightText: 2016 Kai Uwe Broulik <kde@privat.broulik.de>
    SPDX-FileCopyrightText: 2022 ivan (@ratijas) tkachenko <me@ratijas.tk>

    SPDX-License-Identifier: GPL-2.0-or-later
*/

import QtQuick 2.15
import QtQuick.Layouts 1.1

import org.kde.plasma.core 2.0 as PlasmaCore

import org.kde.plasma.plasmoid 2.0

MouseArea {
    id: root
    property bool touchEnabled: true

    Plasmoid.icon: touchEnabled ? Plasmoid.configuration.icon_active : Plasmoid.configuration.icon_inactive
    Plasmoid.title: touchEnabled ? "Disable Touch" : "Enable Touch"

    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground

    Layout.minimumWidth: PlasmaCore.Units.iconSizes.small
    Layout.minimumHeight: PlasmaCore.Units.iconSizes.small

    activeFocusOnTab: true
    hoverEnabled: true

    Plasmoid.onActivated: {
        touchEnabled = !touchEnabled
        executable.exec("qdbus org.kde.KWin /org/kde/KWin/InputDevice/event7 org.kde.KWin.InputDevice.enabled " + touchEnabled);
    }
    onClicked: Plasmoid.activated();

	PlasmaCore.DataSource {
		id: executable
		engine: "executable"
		connectedSources: []
		onNewData: disconnectSource(sourceName)

		function exec(cmd) {
			executable.connectSource(cmd)
		}
	}
	
    Keys.onPressed: {
        switch (event.key) {
        case Qt.Key_Space:
        case Qt.Key_Enter:
        case Qt.Key_Return:
        case Qt.Key_Select:
            Plasmoid.activated();
            break;
        }
    }

    Accessible.name: Plasmoid.title
    Accessible.description: Plasmoid.toolTipSubText
    Accessible.role: Accessible.Button

    PlasmaCore.SvgItem {
        anchors.fill: parent
        svg: PlasmaCore.Svg {
            imagePath: Qt.resolvedUrl(Plasmoid.icon)
        }
    }

    PlasmaCore.ToolTipArea {
        id: toolTip
        anchors.fill: parent
        mainText: Plasmoid.title
        subText: Plasmoid.toolTipSubText
        textFormat: Text.PlainText
    }
}
