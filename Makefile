# ----------------------------------------------------------------------------
#  Copyright (c) 2024 Ali El0malki

#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in all
#  copies or substantial portions of the Software.

#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#  SOFTWARE.
# ----------------------------------------------------------------------------

BUILD_DIR = build
BIN_DIR = $(BUILD_DIR)/bin
TARGET = gmmf
OPT_SAFE = ReleaseFast
OPT_DEBUG = Debug

.PHONY: all clean run install testing debug

all: native
native: clean
	zig build -Doptimize=$(OPT_SAFE) --prefix $(BUILD_DIR)
release: clean
	zig build -Dbuild-all-targets --prefix $(BUILD_DIR)
clean:
	rm -rf $(BUILD_DIR)
run: $(BIN_DIR)/$(TARGET)
	@echo "Running $(TARGET)..."
	@$(BIN_DIR)/$(TARGET)
install:
	@echo "Installing $(TARGET)..."
	mv $(BIN_DIR)/$(TARGET) /usr/local/bin/$(TARGET)
	@echo "Installed $(TARGET) to /usr/local/bin/$(TARGET)"
debug: clean
	zig build -Doptimize=$(OPT_DEBUG) --prefix $(BUILD_DIR)
testing: clean
	zig build test
