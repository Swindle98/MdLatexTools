obsidian_file := $(wildcard build/*_cat.md)
latex_file := $(patsubst %.md,%.tex,$(obsidian_file))
word_file := $(patsubst %.md,%.docx,$(obsidian_file))
bib_file = /Users/mbysjw/Nextcloud/Academia/PhD/External_brain/Academic/AMR\ references/Academic.bib


.PHONY: all
all: $(word_file) $(latex_file) pdf build/bibliography.bib

$(latex_file): $(obsidian_file)
	echo "Generating LaTeX document from $^"
	pandoc -sNC $^ -o $@ --toc=true --lof=true --lot=true

pdf: $(latex_file)
	echo "Generating PDF from $^"
	pdflatex $^

$(word_file): $(obsidian_file)
	echo "Generating Word document from $^"
	pandoc -sNC $^ -o $@ --toc=true --lof=true --lot=true 

sync_md:
	rsync /Users/mbysjw/Nextcloud/Academia/PhD/External_brain/Academic/Academic/2nd\ year\ repotrt/2nd\ year\ report/*_cat.md ./build

build/bibliography.bib:
	@echo "Syncing bibliography file"
	@echo ${bib_file}
	rsync ${bib_file} $@

.PHONY: clean
clean:
	rm -f build/*.tex build/*.docx *.pdf


