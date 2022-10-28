enum IconFile {
  doc,
  pdf,
  ppt,
  xls,
  txt,
  none,
}

extension IconFromFile on IconFile {
  String get assetImage {
    return 'packages/reaction_askany/icons/ic_${name.toLowerCase()}.png';
  }
}
