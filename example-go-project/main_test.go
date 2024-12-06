package main

import (
	"log"
	"testing"

	// add testify assert
	"github.com/stretchr/testify/assert"
)

func TestFoo(t *testing.T) {
	want := "Hello, world!"

	actual := Foo("Hello, worldx!")
	assert.Equal(t, want, actual)
	if want != actual {
		log.Fatalf("Foo() = %v, want %v", actual, want)
	}
}
