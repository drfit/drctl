package version

import (
	"fmt"
	"github.com/go-dr/dr.ctl/cmd/core"
	"github.com/spf13/cobra"

	appVer "github.com/go-dr/dr.ctl/version"
)

func init() {
	versionCmd := &cobra.Command{
		Use:   "version",
		Short: "version of application",
		Long:  "version information for application",
		Run: func(cmd *cobra.Command, args []string) {
			fmt.Printf("%s \nBuildTime:%s\nGitHash:%s\n",
				appVer.Version, appVer.BuildTime, appVer.GitHash)
		},
	}

	// Register versionCmd as sub-command
	core.Register(versionCmd)
}
