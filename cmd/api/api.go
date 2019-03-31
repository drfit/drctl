package api

import (
	"github.com/go-dr/dr-ctl/cmd/core"
	"github.com/go-dr/dr-ctl/pkg/openapi"
	"github.com/spf13/cobra"
)

var specFilePath string

func init() {
	apiCmd := &cobra.Command{
		Use:   "api",
		Short: "Generate Dr. handler code from openapi spec file",
		Long:  "Generate Dr. handler code from openapi spec file that defined by OpenAPI Specification",
		Run:   apiRun,
	}

	// Parse flags for apiCmd
	apiCmd.Flags().StringVarP(&specFilePath, "spec", "s", openapi.DefaultSpecFile, "openapi spec file path")

	// Register helloCmd as sub-command
	core.Register(apiCmd)
}

func apiRun(cmd *cobra.Command, args []string) {
	openapi.BuildFrom(specFilePath)
}
