/*
Copyright 2017 The Nuclio Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package main

import (
	"errors"
	"flag"
	"net/http"
	"os"
	"fmt"
)

func sendRequest(url string) error {
	if url == "" {
		return errors.New("URL must be set")
	}

	resp, err := http.Get(url)
	if err != nil {
		return err
	}

	defer resp.Body.Close()

	return nil
}


func main() {
	url := flag.String("url", "", "Remote URL (e.g. localhost:8070)")

	// parse args
	flag.Parse()

	if err := sendRequest(*url); err != nil {
		fmt.Printf(err.Error())

		os.Exit(1)
	}

	os.Exit(0)
}
