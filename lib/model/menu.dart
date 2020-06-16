class Menu {
  final String text;
  final String iconPath;
  final String path;
  final bool sign;

  Menu({this.text, this.iconPath, this.path, this.sign = false});
}

final List<Menu> menuList = [
  Menu(
      text: 'home.energy',
      iconPath: 'assets/icons/energy_power.png',
      path: 'energy'),
  Menu(text: 'home.volume', iconPath: 'assets/icons/volume.png', path: 'volume'),
  Menu(
      text: 'home.angle',
      iconPath: 'assets/icons/angle.png',
      path: 'angle',
      sign: true),
  Menu(text: 'home.data', iconPath: 'assets/icons/data.png', path: 'data'),
  Menu(
      text: 'home.power',
      iconPath: 'assets/icons/energy_power.png',
      path: 'power',
      sign: true),
  Menu(
      text: 'home.pressure',
      iconPath: 'assets/icons/pressure.png',
      path: 'pressure'),
  Menu(text: 'home.speed', iconPath: 'assets/icons/speed.png', path: 'speed'),
  Menu(text: 'home.time', iconPath: 'assets/icons/time.png', path: 'time'),
  Menu(
      text: 'home.temperature',
      iconPath: 'assets/icons/temperature.png',
      path: 'temperature',
      sign: true),
  Menu(text: 'home.length', iconPath: 'assets/icons/length.png', path: 'length'),
  Menu(text: 'home.mass', iconPath: 'assets/icons/weight.png', path: 'mass'),
  Menu(text: 'home.area', iconPath: 'assets/icons/area.png', path: 'area'),
];
