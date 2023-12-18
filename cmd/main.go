package main

import (
	"os"

	"github.com/taylormonacelli/bigthief"
)

func main() {
	code := bigthief.Execute()
	os.Exit(code)
}
