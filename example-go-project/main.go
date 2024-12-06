package main

import "fmt"

const unused = 1 // this should be a warning

func Foo(s string) string {
	return s
}

func main() {
	fmt.Println("Hello, World!")

	bloop // this should be an error
}
