package version

import (
	"fmt"
	"github.com/go-dr/dr-ctl/cmd/core"
	"github.com/go-dr/dr-ctl/version"
	"github.com/spf13/cobra"
)

func init() {
	versionCmd := &cobra.Command{
		Use:   "version",
		Short: "version of application",
		Long:  "version information for application",
		Run: func(cmd *cobra.Command, args []string) {
			fmt.Printf("%s \nBuildTime:%s\nGitHash:%s\n",
				version.Version, version.BuildTime, version.GitHash)
		},
	}

	// Register versionCmd as sub-command
	core.Register(versionCmd)
}
