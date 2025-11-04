# Default main file
@default_files = ('paper.tex');

# Output directory for all generated files
$out_dir = "_build";

# Custom output name for the PDF (dynamically derived from folder name)
use Cwd;
use File::Basename;
$jobname = basename(getcwd());

# Get absolute paths for directories
my $root_dir = getcwd();

# Tell LaTeX where to find files in the new directories
# Use absolute paths to ensure they work when bibtex changes directory
$ENV{'TEXINPUTS'}="$root_dir/templates/aaai//:$root_dir/templates/acm//:$root_dir/bib//:$root_dir/:" . ($ENV{'TEXINPUTS'} // '');
$ENV{'BIBINPUTS'}="$root_dir/bib//:$root_dir/:" . ($ENV{'BIBINPUTS'} // '');
$ENV{'BSTINPUTS'}="$root_dir/templates/aaai//:$root_dir/templates/acm//:$root_dir/bib//:$root_dir/:" . ($ENV{'BSTINPUTS'} // '');

# Basic configuration
$pdf_mode = 1;
$pdflatex = "pdflatex -interaction=nonstopmode -synctex=1 -jobname=%R %O %S";
$bibtex = "bibtex %O %B";
$clean_ext = "synctex.gz synctex.gz(busy) run.xml log bbl bcf fdb_latexmk run tdo aux out fls";

# Ensure bibtex runs when needed
$bibtex_use = 2;  # Run bibtex whenever it appears necessary

# Create symlink for IDE compatibility after successful build
$success_cmd = "cd %Y && ln -sf $jobname.pdf paper.pdf";