package main

import (
	"log"
	"net/http"
	"os"
)

func main() {
	f, err := os.Create("./data/hello.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()
	hostname, err := os.Hostname()
	if err != nil {
		log.Fatal(err)
	}
	f.WriteString(hostname)
	log.Println("written to file")
	http.ListenAndServe(":8080", nil)
}
