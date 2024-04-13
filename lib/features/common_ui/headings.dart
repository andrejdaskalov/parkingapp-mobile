
import 'package:flutter/material.dart';

class TextElement extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Color color;
  final int maxLines;
  final TextOverflow overflow;

  TextElement(
      {required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.textAlign,
      required this.color,
      required this.maxLines,
      required this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

class TitleHeading extends StatelessWidget {
  final String text;

  const TitleHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextElement(
          text: text,
          fontSize: 29,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.start,
          color: Theme.of(context).colorScheme.onBackground,
          maxLines: 1,
          overflow: TextOverflow.ellipsis),
    );
  }
}

class SubtitleHeading extends StatelessWidget {
  final String text;

  const SubtitleHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: TextElement(
          text: text,
          fontSize: 19,
          fontWeight: FontWeight.normal,
          textAlign: TextAlign.start,
          color: Theme.of(context).colorScheme.onBackground,
          maxLines: 1,
          overflow: TextOverflow.ellipsis),
    );
  }
}

class BoldHeading extends StatelessWidget {
  final String text;

  const BoldHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: TextElement(
          text: text,
          fontSize: 19,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.start,
          color: Theme.of(context).colorScheme.onBackground,
          maxLines: 1,
          overflow: TextOverflow.ellipsis),
    );
  }
}

class ZoneHeading extends StatelessWidget {
  final String text;

  const ZoneHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextElement(
        text: text,
        fontSize: 29,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.start,
        color: Theme.of(context).colorScheme.primary,
        maxLines: 1,
        overflow: TextOverflow.ellipsis);
  }
}

class ZoneLabel extends StatelessWidget {
  final String text;

  const ZoneLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextElement(
        text: text,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.start,
        color: Theme.of(context).colorScheme.primary,
        maxLines: 1,
        overflow: TextOverflow.ellipsis);
  }
}