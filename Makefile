TMPFILE=a

playback: $(TMPFILE).wav
	play $(TMPFILE).wav

$(TMPFILE): prolaudi
	./prolaudi >$(TMPFILE)

$(TMPFILE).wav: $(TMPFILE)
	 ffmpeg -f f32le -i $(TMPFILE) -c:a pcm_s16le -y $(TMPFILE).wav


