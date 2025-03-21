include config.mk
PLAYER ?= pulseaudio
#PLAYER ?= pipewire
TMPFILE=a

stream: stream-$(PLAYER)

stream-pipewire	:
	./prolaudi |\
	pw-play --format f32 --channels 1 --rate 44100 -

stream-pulseaudio :
	./prolaudi |\
	paplay --format=float32le --channels=1 --rate=44100 -

.PHONY: stream stream-$(PLAYER)

#play -
#ffmpeg -hide_banner -loglevel 32 -f f32le -i - -f pulse default

playback: $(TMPFILE).wav
	play -q $(TMPFILE).wav

$(TMPFILE): prolaudi
	./prolaudi >$(TMPFILE)

$(TMPFILE).wav: $(TMPFILE)
	 ffmpeg -hide_banner -loglevel 32 -f f32le -i $(TMPFILE) -c:a pcm_s16le -y $(TMPFILE).wav


