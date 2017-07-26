package com.mun.model.component;

import com.mun.model.enumeration.IOTYPE;
import com.mun.model.enumeration.VALUE_LOGIC;

class Outport implements Port {
    var xPosition:Float;
    var yPosition:Float;
    var portDescription:IOTYPE;
    var value:VALUE_LOGIC;
    var sequence:Int;

    public function get_xPosition():Float {
        return xPosition;
    }

    public function get_yPosition():Float {
        return yPosition;
    }

    public function set_xPosition(xPosition:Float):Void {
        this.xPosition = xPosition;
    }

    public function set_yPosition(yPosition:Float):Void {
        this.yPosition = yPosition;
    }

    public function get_value():VALUE_LOGIC {
        return value;
    }

    public function set_value(value:VALUE_LOGIC):Void {
        this.value = value;
    }

    public function get_portDescription():IOTYPE {
        return portDescription;
    }

    public function set_portDescription(value:IOTYPE):Void {
        this.portDescription = value;
    }

    public function get_sequence():Int {
        return sequence;
    }

    public function set_sequence(sequence:Int):Void {
        this.sequence = sequence;
    }

    public function new(?xPosition:Float, ?yPosition:Float) {
        this.xPosition = xPosition;
        this.yPosition = yPosition;
        portDescription = IOTYPE.OUTPUT;
    }

    public function createXML():Xml{
        var OutportXML:Xml = Xml.createElement("Outport");
        var xPositionXML:Xml = Xml.createElement("xPosition");
        OutportXML.addChild(xPositionXML);
        xPositionXML.addChild(Xml.createPCData(xPosition + ""));

        var yPositionXML:Xml = Xml.createElement("yPosition");
        OutportXML.addChild(yPositionXML);
        yPositionXML.addChild(Xml.createPCData(yPosition + ""));

        var portDescriptionXML:Xml = Xml.createElement("portDescription");
        OutportXML.addChild(portDescriptionXML);
        portDescriptionXML.addChild(Xml.createPCData(portDescription + ""));

        var sequenceXML:Xml = Xml.createElement("sequence");
        OutportXML.addChild(sequenceXML);
        sequenceXML.addChild(Xml.createPCData(sequence + ""));

        return OutportXML;
    }
}
