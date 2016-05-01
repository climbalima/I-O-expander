#----------------------------------------------------------------------------
# On command line:
#
# make = Make software.
#
# make clean = Clean out built project files.
#
# That's pretty much all you need. To compile, always go make clean, 
# followed by make.
#
# For advanced users only:
# make teensy = Download the hex file to the device, using teensy_loader_cli.
#               (must have teensy_loader_cli installed).
#
#----------------------------------------------------------------------------

# Target file name (without extension).
TARGET = ergodox_ez


# Directory common source filess exist
TOP_DIR = ../..
TMK_DIR = ../../tmk_core

# Directory keyboard dependent files exist
TARGET_DIR = .

# # project specific files
SRC = ergodox_ez.c \
	  twimaster.c \
	  matrix.c

ifdef KEYMAP
    SRC := keymaps/$(KEYMAP)/keymap.c $(SRC)
else
    SRC := keymaps/default/keymap.c $(SRC)
endif

CONFIG_H = config.h

# MCU name
MCU = atmega32u4

# Processor frequency.
#     This will define a symbol, F_CPU, in all source code files equal to the
#     processor frequency in Hz. You can then use this symbol in your source code to
#     calculate timings. Do NOT tack on a 'UL' at the end, this will be done
#     automatically to create a 32-bit value in your source code.
#
#     This will be an integer division of F_USB below, as it is sourced by
#     F_USB after it has run through any CPU prescalers. Note that this value
#     does not *change* the processor frequency - it should merely be updated to
#     reflect the processor speed set externally so that the code can use accurate
#     software delays.
F_CPU = 16000000


#
# LUFA specific
#
# Target architecture (see library "Board Types" documentation).
ARCH = AVR8

# Input clock frequency.
#     This will define a symbol, F_USB, in all source code files equal to the
#     input clock frequency (before any prescaling is performed) in Hz. This value may
#     differ from F_CPU if prescaling is used on the latter, and is required as the
#     raw input clock is fed directly to the PLL sections of the AVR for high speed
#     clock generation for the USB and other AVR subsections. Do NOT tack on a 'UL'
#     at the end, this will be done automatically to create a 32-bit value in your
#     source code.
#
#     If no clock division is performed on the input clock inside the AVR (via the
#     CPU clock adjust registers or the clock division fuses), this will be equal to F_CPU.
F_USB = $(F_CPU)

# Interrupt driven control endpoint task(+60)
OPT_DEFS += -DINTERRUPT_CONTROL_ENDPOINT


# Boot Section Size in *bytes*
#   Teensy halfKay   512
#   Teensy++ halfKay 1024
#   Atmel DFU loader 4096
#   LUFA bootloader  4096
#   USBaspLoader     2048
OPT_DEFS += -DBOOTLOADER_SIZE=512


# Build Options
#   comment out to disable the options.
#
BOOTMAGIC_ENABLE = yes # Virtual DIP switch configuration(+1000)
MOUSEKEY_ENABLE  = yes # Mouse keys(+4700)
EXTRAKEY_ENABLE  = yes # Audio control and System control(+450)
# CONSOLE_ENABLE   = yes # Console for debug(+400)
COMMAND_ENABLE   = yes # Commands for debug and configuration
CUSTOM_MATRIX    = yes # Custom matrix file for the ErgoDox EZ
SLEEP_LED_ENABLE = yes  # Breathing sleep LED during USB suspend
NKRO_ENABLE      = yes		# USB Nkey Rollover - if this doesn't work, see here: https://github.com/tmk/tmk_keyboard/wiki/FAQ#nkro-doesnt-work
# MIDI_ENABLE    = yes 		# MIDI controls
# UNICODE_ENABLE = yes 		# Unicode


# Optimize size but this may cause error "relocation truncated to fit"
#EXTRALDFLAGS = -Wl,--relax

# Search Path
VPATH += $(TARGET_DIR)
VPATH += $(TOP_DIR)
VPATH += $(TMK_DIR)

include $(TOP_DIR)/quantum/quantum.mk
