import 'package:flutter/material.dart';
import 'package:u_bipperr_app/colors.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false,home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class GradientIcon extends StatelessWidget {
  GradientIcon(
      this.icon,
      this.size,
      this.gradient,
      );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final page = ({Widget child}) => Styled.widget(child: child)
        .padding(vertical: 30, horizontal: 20)
        .constrained(minHeight: MediaQuery.of(context).size.height - (2 * 30))
        .scrollable()
        .backgroundColor(CustomColors.WhiteBackground);

    return <Widget>[
      Text(
        'Impostazioni',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28,),
      ).alignment(Alignment.center).padding(bottom: 20),
      Settings().padding(top: 10),
    ].toColumn().parent(page);
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final page = ({Widget child}) => Styled.widget(child: child)
        .padding(vertical: 30, horizontal: 20)
        .constrained(minHeight: MediaQuery.of(context).size.height - (2 * 30))
        .scrollable()
        .backgroundColor(CustomColors.WhiteBackground);

    return <Widget>[
      Text(
        'Dispositivo',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28,),
      ).alignment(Alignment.center).padding(bottom: 20),
      UserCard().elevation(20),
    ].toColumn().parent(page);
  }
}


class UserCard extends StatelessWidget {
  Widget _buildUserRow() {
    return <Widget>[
      Icon(Icons.account_circle)
          .decorated(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      )
          .constrained(height: 50, width: 50)
          .padding(right: 10),
      <Widget>[
        Text(
          'U Bipperr',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    ].toRow();
  }

  Widget _buildUserStats() {
    return <Widget>[
      _buildUserStatsItem('846', 'Test1'),
      _buildUserStatsItem('51', 'Test2'),
      _buildUserStatsItem('267', 'Test3'),
      _buildUserStatsItem('39', 'Test4'),
    ]
        .toRow(mainAxisAlignment: MainAxisAlignment.spaceAround)
        .padding(vertical: 10);
  }

  Widget _buildUserStatsItem(String value, String text) => <Widget>[
    Text(value).fontSize(20).textColor(Colors.white).padding(bottom: 5),
    Text(text).textColor(Colors.white.withOpacity(0.6)).fontSize(12),
  ].toColumn();

  @override
  Widget build(BuildContext context) {
    return <Widget>[_buildUserRow(), _buildUserStats()]
        .toColumn(mainAxisAlignment: MainAxisAlignment.spaceAround)
        .padding(horizontal: 20, vertical: 10)
        .decorated(
        gradient: LinearGradient(begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [CustomColors.Blue, CustomColors.GreyBlue]),
        borderRadius: BorderRadius.circular(20))
        .elevation(
      5,
      shadowColor: CustomColors.Blue,
      borderRadius: BorderRadius.circular(20),
    )
        .height(175)
        .alignment(Alignment.center);
  }
}


class SettingsItemModel {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  const SettingsItemModel({
    @required this.color,
    @required this.description,
    @required this.icon,
    @required this.title,
  });
}

const List<SettingsItemModel> settingsItems = [
  SettingsItemModel(
    icon: Icons.location_on,
    color: Color(0xff8D7AEE),
    title: 'Geolocalizzazione',
    description: 'Geolocalizzazione attiva',
  ),
  SettingsItemModel(
    icon: Icons.timer,
    color: Color(0xffFEC85C),
    title: 'Intervallo',
    description: "Intervallo di emissione del suono di ferma",
  ),
  SettingsItemModel(
    icon: Icons.notifications,
    color: Color(0xff5FD0D3),
    title: 'Suono',
    description: 'Frequenza in Hz del suono emesso',
  ),
  SettingsItemModel(
    icon: Icons.settings_power,
    color: Color(0xffF468B7),
    title: 'Accensione/Spegnimento',
    description: 'Suono di accensione/spegnimento',
  ),
  SettingsItemModel(
    icon: Icons.book,
    color: Color(0xffBFACAA),
    title: 'Seriale',
    description: 'Comunicazione seriale ESP32',
  ),
];

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) => settingsItems
      .map((settingsItem) => SettingsItem(
    settingsItem.icon,
    settingsItem.color,
    settingsItem.title,
    settingsItem.description,
  ))
      .toList()
      .toColumn();
}

class SettingsItem extends StatefulWidget {
  SettingsItem(this.icon, this.iconBgColor, this.title, this.description);

  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String description;

  @override
  _SettingsItemState createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    final settingsItem = ({Widget child}) => Styled.widget(child: child)
        .alignment(Alignment.center)
        .borderRadius(all: 15)
        .ripple()
        .backgroundColor(Colors.white, animate: true)
        .clipRRect(all: 25) // clip ripple
        .borderRadius(all: 25, animate: true)
        .elevation(
      pressed ? 0 : 20,
      borderRadius: BorderRadius.circular(25),
      shadowColor: Color(0xFFF0F0F0),
    ) // shadow borderRadius
        .constrained(height: 80)
        .padding(vertical: 10) // margin
        .gestures(
      onTapChange: (tapStatus) => setState(() => pressed = tapStatus),
      onTapDown: (details) => print('tapDown'),
      onTap: () => print('onTap'),
    )
        .scale(all:(pressed ? 0.95 : 1.0), animate: true)
        .animate(Duration(milliseconds: 150), Curves.easeOut);

    final Widget icon = Icon(widget.icon, size: 20, color: Colors.white)
        .padding(all: 12)
        .decorated(
      color: widget.iconBgColor,
      borderRadius: BorderRadius.circular(30),
    )
        .padding(left: 15, right: 10);

    final Widget title = Text(
      widget.title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ).padding(bottom: 5);

    final Widget description = Text(
      widget.description,
      style: TextStyle(
        color: Colors.black26,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );

    return settingsItem(
      child: <Widget>[
        icon,
        <Widget>[
          title,
          description,
        ].toColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ].toRow(),
    );
  }
}



class _MyAppState extends State<MyApp> {
  int _selectedTabIndex = 0;

  List _pages = [
    SafeArea(child: HomePage()),
    SafeArea(child: SettingsPage()),];

  _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: CustomColors.WhiteBackground, statusBarIconBrightness: Brightness.dark //or set color with: Color(0xFF0000FF)
    ));
    return Scaffold(
      body: Center(child: _pages[_selectedTabIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor:Colors.black54,
        unselectedItemColor: Colors.black54,
        unselectedIconTheme: IconThemeData(color:Colors.black54),
        onTap: _changeIndex,
        items: [
          BottomNavigationBarItem(
              activeIcon:GradientIcon(Icons.dashboard_rounded, 24, LinearGradient(begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [CustomColors.Blue, CustomColors.GreyBlue])),
              icon:Icon(Icons.dashboard_rounded,color: Colors.black54),
              label: "Attività"),
          BottomNavigationBarItem(
              activeIcon: GradientIcon(Icons.settings_rounded, 24, LinearGradient(begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [CustomColors.Blue, CustomColors.GreyBlue])),
              icon:Icon(Icons.settings_rounded,color:Colors.black54),
              label: "Impostazioni"),
        ],
      ),
    );
  }
}