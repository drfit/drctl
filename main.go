package main

import (
	"github.com/go-dr/dr-ctl/cmd/core"

	_ "github.com/go-dr/dr-ctl/cmd/api"
	_ "github.com/go-dr/dr-ctl/cmd/version"
)

func main() {
	// Setup root cli command of application
	core.Setup(
		"dr-ctl",                       // command name
		"dr-ctl is a cli tool for Dr.", // command short describe
		"dr-ctl is a cli tool for Dr.", // command long describe
	)

	// Execute start application
	core.Execute()
}
