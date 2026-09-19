{ ... }:

{
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      version = 3;

      var = {
        Filler = "<#808080>─</>";
      };

      secondary_prompt = {
        template = " ❯❯ ";
        foreground = "magenta";
        background = "transparent";
      };

      transient_prompt = {
        template = " ❯ ";
        foreground = "#ffffff";
        background = "transparent";
        foreground_templates = [
          "{{if gt .Code 0 }}red{{end}}"
          "{{if eq .Code 0 }}magenta{{end}}"
        ];
        newline = true;
      };

      blocks = [
        {
          type = "prompt";
          alignment = "left";
          newline = true;

          segments = [
            {
              template = ''╭─[<#55ff55>{{ .UserName }}</><#ff5555>@</><#ffff55>{{ .HostName }}</>]{{ .Var.Filler }}'';
              type = "session";
              style = "plain";
            }
            {
              template = ''<#ffffff>[</><b>{{ .Path }}</b><#ffffff>]</>'';
              foreground = "#6395ee";
              type = "path";
              style = "plain";

              properties = {
                style = "full";
              };
            }
            {
              template = ''{{ .Var.Filler }}<#ffffff>(</>{{ .HEAD }}{{ if .Staging.Changed }}<#00AA00> ● {{ .Staging.String }}</>{{ end }}{{ if .Working.Changed }}<#D75F00> ● {{ .Working.String }}</>{{ end }}<#ffffff>)</>'';
              foreground = "#e0f8ff";
              type = "git";
              style = "plain";

              properties = {
                branch_icon = " ";
                fetch_status = true;
                fetch_upstream_icon = true;
              };
            }
          ];
        }

        {
          type = "prompt";
          alignment = "right";
          filler = "<#808080>─</>";

          segments = [
            {
              template = ''{{ if gt .Code 0 }}{{ .Code }}{{ .Var.Filler }}{{ end }}'';
              foreground = "#FF3333";
              type = "status";
              style = "plain";

              properties = {
                always_enabled = true;
              };
            }
            {
              template = ''<#ffffff>(</>{{ if .PackageManagerIcon }}{{ .PackageManagerIcon }} {{ end }}{{ .Full }}<#ffffff>)</>'';
              foreground = "#3C873A";
              type = "node";
              style = "plain";

              properties = {
                fetch_package_manager = true;
                npm_icon = " <#cc3a3a> </> ";
                yarn_icon = " <#348cba> </>";
              };
            }
            {
              template = ''<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ if .Venv }}{{ .Venv }} {{ end }}{{ .Full }}{{ end }}<#ffffff>)</>'';
              foreground = "#FFE873";
              type = "python";
              style = "plain";
            }
            {
              template = ''<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>'';
              foreground = "#ec2729";
              type = "java";
              style = "plain";
            }
            {
              template = ''<#ffffff>(</>{{ if .Unsupported }} {{ else }}{{ .Full }}{{ end }}<#ffffff>)</>'';
              foreground = "#0d6da8";
              type = "dotnet";
              style = "plain";
            }
            {
              template = ''<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>'';
              foreground = "#06aad5";
              type = "go";
              style = "plain";
            }
            {
              template = ''<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>'';
              foreground = "#925837";
              type = "rust";
              style = "plain";
            }
            {
              template = ''<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>'';
              foreground = "#055b9c";
              type = "dart";
              style = "plain";
            }
            {
              template = ''<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>'';
              foreground = "#ce092f";
              type = "angular";
              style = "plain";
            }
            {
              template = ''<#1e293b>(</>{{ if .Error }}{{ .Error }}{{ else }}Nx {{ .Full }}{{ end }}<#1e293b>)</>'';
              foreground = "#ffffff";
              type = "nx";
              style = "plain";
            }
            {
              template = ''<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>'';
              foreground = "#359a25";
              type = "julia";
              style = "plain";
            }
            {
              template = ''<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>'';
              foreground = "#9c1006";
              type = "ruby";
              style = "plain";
            }
            {
              template = ''<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>'';
              foreground = "#5398c2";
              type = "azfunc";
              style = "plain";
            }
            {
              template = ''<#ffffff>(</>{{.Profile}}{{if .Region}}@{{.Region}}{{end}}<#ffffff>)</>'';
              foreground = "#faa029";
              type = "aws";
              style = "plain";
            }
            {
              template = ''<#ffffff>(</>{{.Context}}{{if .Namespace}} :: {{.Namespace}}{{end}}<#ffffff>)</>'';
              foreground = "#316ce4";
              type = "kubectl";
              style = "plain";
            }
            {
              template = ''<#ffffff>(</>{{ if .WSL }}WSL at {{ end }}{{.Icon}}<#ffffff> )</>{{ .Var.Filler }}'';
              foreground = "#ffffff";
              type = "os";
              style = "plain";

              properties = {
                linux = "<#ffffff> </>";
                macos = "<#ffffff> </>";
                windows = "<#ffffff> </>";
              };
            }
            {
              template = ''<#ffffff>[</>{{ if not .Error }}{{ .Icon }}{{ .Percentage }}{{ end }}{{ .Error }}%<#ffffff>]─</>'';
              foreground = "#ffffff";
              type = "battery";
              style = "plain";
              foreground_templates = [
                ''{{if eq "Charging" .State.String}}#40c4ff{{end}}''
                ''{{if eq "Discharging" .State.String}}#FFFB38{{end}}''
                ''{{if eq "Full" .State.String}}#33DD2D{{end}}''
              ];

              properties = {
                charged_icon = " ";
                charging_icon = " ";
                discharging_icon = " ";
              };
            }
            {
              template = ''<#ffffff>[</> {{ .CurrentDate | date .Format }}<#ffffff>]</>'';
              foreground = "#55ffff";
              type = "time";
              style = "plain";

              properties = {
                time_format = "_2,15:04";
              };
            }
          ];
        }

        {
          type = "prompt";
          alignment = "left";

          segments = [
            {
              template = "╰─➤";
              type = "text";
              style = "plain";
            }
            {
              template = ''{{ if .Root }}# {{ else }}$ {{ end }}'';
              foreground = "#ecf7fa";
              type = "status";
              style = "plain";
              foreground_templates = [
                "{{ if .Root }}#FF9248{{ end }}"
                "{{ if gt .Code 0 }}#ef5350{{ end }}"
              ];

              properties = {
                always_enabled = true;
              };
            }
          ];
        }

        {
          type = "rprompt";
          overflow = "hidden";

          segments = [
            {
              template = "{{ .FormattedMs }}  ";
              foreground = "yellow";
              background = "transparent";
              type = "executiontime";
              style = "plain";

              properties = {
                style = "austin";
                threshold = 3000;
              };
            }
          ];
        }
      ];
    };
  };
}
