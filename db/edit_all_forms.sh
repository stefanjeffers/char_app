sed "s/,[ 'a-z0-9_.]*,[ 'a-z0-9_.]*);/);/" < $1 > removed_fields_out.sql

# sed "s/ [0-9],//"
# sed "s/all_forms/formulas/"
# sed "s/formulas/formulas( base, offset, subindex, iform, word_form, abbrev_form, alpha, created_at, updated_at )/"
# sed "s/'_'/'0'/"
# sed "s/);/, datetime('now'), datetime'now') );/"



