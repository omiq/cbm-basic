## Portable Makefile for cbm-basic
##
## Targets:
##   make         - build native binary for the current host
##   make clean   - remove built binary

TARGET = basic
SRCS   = basic.c petscii.c

# Optional gfx/test modules (feature/raylib-gfx branch)
GFX_SRCS = gfx/gfx_video.c tests/gfx_video_test.c

# Reasonable defaults for modern systems; can be overridden on the command line.
CC      ?= cc
CFLAGS  ?= -Wall -std=c99 -O2
LDFLAGS ?= -lm

# Basic cross-platform tweaks for Windows vs POSIX
ifeq ($(OS),Windows_NT)
  EXE := .exe
  RM  := del /F /Q
else
  EXE :=
  RM  := rm -f
endif

all: $(TARGET)$(EXE)

$(TARGET)$(EXE): $(SRCS)
	$(CC) $(CFLAGS) -o $@ $(SRCS) $(LDFLAGS)

gfx_video_test: $(GFX_SRCS)
	$(CC) $(CFLAGS) -Igfx -o $@ $(GFX_SRCS) $(LDFLAGS)

clean:
	$(RM) $(TARGET)$(EXE) gfx_video_test

.PHONY: all clean gfx_video_test

# End of Makefile
