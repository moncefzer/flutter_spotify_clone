extension BoolExt on bool? {
  get ifNullTrue => this ?? true;

  get ifNullFalse => this ?? false;
}
