/// Save/load the world grid to a simple text file in the sandbox.
/// Format:
///   Line 1: W,H
///   Lines 2..H+1: one row per line as 0/1 characters of length W

function world_save(filename) {
    var W = global.WORLD_W;
    var H = global.WORLD_H;
    if (W <= 0 || H <= 0) return false;

    var fh = file_text_open_write(filename);
    if (fh < 0) return false;

    // header "W,H"
    var header = string(W) + "," + string(H);
    file_text_write_string(fh, header);
    file_text_writeln(fh); // newline

    // rows
    for (var r = 0; r < H; r++) {
        var row = "";
        var base = r * W;
        for (var c = 0; c < W; c++) {
            row += string(global.WORLD_GRID[base + c]); // expects 0 or 1
        }
        file_text_write_string(fh, row);
        file_text_writeln(fh); // newline
    }

    file_text_close(fh);
    return true;
}

function world_load(filename) {
    if (!file_exists(filename)) return false;

    var fh = file_text_open_read(filename);
    if (fh < 0) return false;

    // read header "W,H"
    var header = file_text_read_string(fh);
    file_text_readln(fh); // consume newline

    var comma = string_pos(",", header);
    if (comma <= 0) { file_text_close(fh); return false; }

    var W = real(string_copy(header, 1, comma - 1));
    var H = real(string_copy(header, comma + 1, string_length(header) - comma));
    if (W <= 0 || H <= 0) { file_text_close(fh); return false; }

    // allocate
    global.WORLD_W = W;
    global.WORLD_H = H;
    global.WORLD_GRID = array_create(W * H, 0);

    // read rows
    for (var r = 0; r < H; r++) {
        if (file_text_eof(fh)) break;
        var row = file_text_read_string(fh);
        file_text_readln(fh); // consume newline

        var len = min(string_length(row), W);
        var base = r * W;
        for (var c = 0; c < len; c++) {
            var ch = string_byte_at(row, c + 1); // '0'..'1' (48/49)
            global.WORLD_GRID[base + c] = (ch == 49) ? 1 : 0;
        }
    }

    file_text_close(fh);
    return true;
}
