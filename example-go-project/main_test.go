package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestFooAlwaysFails(t *testing.T) {
	want := "world"
	actual := Foo("helloz")
	assert.Equal(t, want, actual)
}
