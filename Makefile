include config.mk
PLAYER ?= pipewire
FFMPEG_LOG_LEVEL ?= 24
FFMPEG_DSP ?= -af ladspa=file=tap_reverb:tap_reverb
TMPFILE ?= a

stream: stream-$(PLAYER)

stream-pipewire-reverb	:
	./prolaudi |\
	ffmpeg -hide_banner -loglevel $(FFMPEG_LOG_LEVEL) \
		-f f32le -channel_layout mono -i - \
		$(FFMPEG_DSP) -f f32le - |\
	pw-play --format f32 --channels 2 --rate 44100 -

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
	 #ffmpeg -hide_banner -loglevel 32 -f f32le -i $(TMPFILE) -c:a pcm_s16le -y $(TMPFILE).wav
	 ffmpeg -hide_banner -loglevel $(FFMPEG_LOG_LEVEL) -f f32le -i $(TMPFILE) -$(FFMPEG_DSP),dynaudnorm -c:a pcm_s16le -y $(TMPFILE).wav


