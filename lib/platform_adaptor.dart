library platform_adaptor;

import 'package:flutter/material.dart';

const mobileBreakpoint = 768;
const tabletBreakpoint = 1024;
const widescreenBreakPoint = 1500;

/// Any Screen/Page that is rendered differently over android and desktop.
/// [narrowLayout] : returned on mobile view (below 768 pixels)
/// [wideLayout] : returned on desktop view (above 1024 pixels)
PlatformAdaptor({
  loading: false,
  required Function narrowLayout,
  required Function wideLayout,
}) {
  return Scaffold(
    body: LayoutBuilder(
      builder: (context, constraints) {
        // if (loading) return Loading();

        if (constraints.maxWidth < mobileBreakpoint)
          return narrowLayout();
        else
          return wideLayout();
      },
    ),
  );
}

/// Any Widget that is rendered differently over android and desktop.
/// [narrowLayout] : returned on mobile view (below 768 pixels)
/// [wideLayout] : returned on desktop view (above 1024 pixels)
PlatformWidgetAdaptor({
  loading: false,
  required Function narrowLayout,
  required Function wideLayout,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // if (loading) return Loading();

      double width = MediaQuery.of(context).size.width;

      if (width < mobileBreakpoint)
        return narrowLayout();
      else
        return wideLayout();
    },
  );
}

/// Any Widget that changes over a breakpoint within a widget.
/// [narrowLayout] : returned on widget width being less than breakpoint.
/// [wideLayout] : returned on widget width being more than breakpoint.
Widget WidgetAdaptor({
  loading: false,
  required Widget narrowLayout,
  required Widget wideLayout,
  double breakPoint: 400,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // if (loading) return Loading();

      if (constraints.maxWidth < breakPoint)
        return narrowLayout;
      else
        return wideLayout;
    },
  );
}

/// Any settings that changes over android and desktop.
/// [narrowLayout] : returned on mobile view (below 768 pixels)
/// [wideLayout] : returned on desktop view (above 1024 pixels)
dynamic SettingsAdaptor({
  required BuildContext context,
  dynamic narrowLayout: null,
  dynamic wideLayout: null,
  bool isCallable: false,
}) {
  double width = MediaQuery.of(context).size.width;

  if (width < mobileBreakpoint)
    return isCallable ? narrowLayout() : narrowLayout;
  else
    return isCallable ? wideLayout() : wideLayout;
}

class PlatformType {
  BuildContext context;

  PlatformType.of(this.context);

  /// Returns true if screen size is less than 768 pixels
  bool isMobile() {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  /// Returns true if screen size is between 768 and 1024 pixels.
  bool isTablet() {
    return (MediaQuery.of(context).size.width >= mobileBreakpoint &&
        MediaQuery.of(context).size.width < tabletBreakpoint);
  }

  /// Returns true if screen size is greater than 1024 pixels
  bool isDesktop() {
    return !isTablet() && !isMobile();
  }

  /// Returns true if screen size is above 1500 pixels
  bool isWideScreen() {
    return MediaQuery.of(context).size.width >= widescreenBreakPoint;
  }
}
