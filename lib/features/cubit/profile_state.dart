abstract class ProfileState {
  final String name;
  const ProfileState(this.name);
}

class ProfileInitial extends ProfileState {
  const ProfileInitial(String name): super(name);
}
