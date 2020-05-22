#alias g="cd $GOPATH/src/github.com/`git config --get github.user`"
alias g="cd $GOPATH/src/"
alias go-test-color='go test -v ./... | sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'''
