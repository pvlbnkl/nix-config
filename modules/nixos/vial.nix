{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.vial;
in
{
  options.modules.nixos.vial.enable = lib.mkEnableOption "hidraw access for Vial-firmware keyboards";

  config = lib.mkIf cfg.enable {
    # https://get.vial.today/manual/linux-udev.html
    # 59- so the uaccess tag lands before systemd's 73-seat-late.rules.
    services.udev.packages = [
      (pkgs.writeTextFile {
        name = "vial-udev-rules";
        destination = "/etc/udev/rules.d/59-vial.rules";
        text = ''
          KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
        '';
      })
    ];
  };
}
