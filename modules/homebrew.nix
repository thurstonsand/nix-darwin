{...}: {
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      cleanup = "uninstall";
      upgrade = true;
    };
    global = {
      autoUpdate = true;
    };

    casks = [
      "1password"
      "1password-cli"
      "chatgpt"
      "discord"
      "arc"
      "beeper"
      "contexts"
      "cursor"
      "discord"
      "fantastical"
      "google-drive"
      "mac-mouse-fix"
      "moonlight"
      "orion"
      "raycast"
      "reflect"
      "setapp"
      "warp"
      "wifiman"
      "zed"
    ];

    validateMasApps = true;
    # NOTE: apps removed from this list are not uninstalled
    # a limitation of Homebrew Bundle
    masApps = {
      "1Password for Safari" = 1569813296;
      "Access" = 6469049274;
      "Copilot" = 1447330651;
      "Dark Reader for Safari" = 1438243180;
      "Kagi for Safari" = 1622835804;
      "Mela" = 1568924476;
      "NextDNS" = 1464122853;
      "Parcel" = 639968404;
      "Save to Reader" = 1640236961;
      "Telegram" = 747648890;
      "WhatsApp" = 310633997;
      "Wipr" = 1662217862; # actually Wipr 2
    };
  };
}
