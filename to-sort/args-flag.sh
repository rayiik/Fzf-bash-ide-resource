rg -e '^[ \s\ta-z].\b\w[a-z-]*[ \s]\b' --only-matching -e '\B-[-a-z]*\b' | sed -e 's/[[:space:]]//'
