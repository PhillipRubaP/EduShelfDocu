@echo off
echo ==========================================
echo      EduShelf Documentation Builder
echo ==========================================

:: Check if pdflatex exists
where pdflatex >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: pdflatex not found. Please install MiKTeX or add it to PATH.
    pause
    exit /b
)

echo.
echo [1/4] Cleaning temporary files...
del *.aux *.log *.out *.toc *.bbl *.blg *.run.xml *.bcf *.lof *.lot 2>nul

echo.
echo [2/4] Compiling main.tex (Pass 1/3)...
pdflatex -interaction=nonstopmode main.tex
if %errorlevel% neq 0 (
    echo.
    echo Error during compilation! Check main.log for details.
    pause
    exit /b
)

echo.
echo [3/4] Running Biber (Bibliography)...
biber main

echo.
echo [4/4] Compiling main.tex (Pass 2/3)...
pdflatex -interaction=nonstopmode main.tex

echo.
echo [4/4] Compiling main.tex (Pass 3/3)...
pdflatex -interaction=nonstopmode main.tex

echo.
echo ==========================================
echo        Build Successful! :)
echo ==========================================
echo Opening main.pdf...
start main.pdf
pause
