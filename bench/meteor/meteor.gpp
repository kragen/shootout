// The Computer Language Benchmarks Game
//  http://shootout.alioth.debian.org
//  contributed by Kevin Barnes

#include <memory.h>
#include <cstdio>
#include <cstdlib>
#include <ctime>
#include <iostream>
#include <vector>
#include <string>
#include <set>

using namespace std;

#define WEST 0
#define EAST 1
#define SW 2
#define SE 3
#define NW 4
#define NE 5

#define BIT ((long long)1)

// constant masks
const long long row_mask = (long long)31;
const long long full_mask = (BIT << 50) - 1;
const long long row_masks[] = { row_mask, row_mask << 5, row_mask << 10, row_mask << 15, row_mask << 20, row_mask << 25, row_mask << 30,
row_mask << 35, row_mask << 40, row_mask << 45 };
const long long all_even_rows = row_masks[0] | row_masks[2] | row_masks[4] | row_masks[6] | row_masks[8];
const long long all_odd_rows = row_masks[1] | row_masks[3] | row_masks[5] | row_masks[7] | row_masks[9];
const long long all_rows[2] = { all_even_rows, all_odd_rows };

const long long even_left_edges = BIT | (BIT << 10) | (BIT << 20) | (BIT << 30 | (BIT << 40));
const long long odd_left_edges = (BIT << 5) | (BIT << 15) | (BIT << 25) | (BIT << 35) | (BIT << 45);
const long long left_edges = even_left_edges | odd_left_edges;
const long long even_right_edges = even_left_edges << 4;
const long long odd_right_edges = odd_left_edges << 4;
const long long right_edges = left_edges << 4;
const long long top_edge = row_masks[0];
const long long bottom_edge = row_masks[9];

const long long illegal_move_masks[6] = {
   left_edges, right_edges,
   bottom_edge | even_left_edges, bottom_edge | odd_right_edges,
   top_edge | even_left_edges, top_edge | odd_right_edges };

// mapping and bit manipulation
inline int location_of( int row, int col) { return row * 5 + col; }
inline int row_of( int location) { return location / 5; }
inline int col_of( int location) { return location % 5; }
inline long long get_bit( long long value, int pos) { return value & (BIT << pos); }
inline long long get_bit( long long value, int row, int col) { return value & (BIT << location_of(row, col)); }
inline long long has_bit( long long value, int pos) { return get_bit(value, pos) ? true : false; }
inline long long has_bit( long long value, int row, int col) { return get_bit(value, row, col) ? true : false;  }
inline void set_bit( long long &value, int pos) { value |= (BIT << pos); }
inline void set_bit( long long &value, int row, int col) { value |= (BIT << location_of(row, col)); }
inline int get_row( long long mask, int row) { return (int)((mask >> (row * 5)) & row_mask); }

inline long long shift_east( const long long mask) { return mask << 1; }
inline long long shift_west( const long long mask) { return mask >> 1; }
inline long long shift_nw( const long long mask) { return ((mask & all_even_rows) >> 6) | ((mask & all_odd_rows) >> 5); }
inline long long shift_ne( const long long mask) { return ((mask & all_even_rows) >> 5) | ((mask & all_odd_rows) >> 4); }
inline long long shift_sw( const long long mask) { return ((mask & all_even_rows) << 4) | ((mask & all_odd_rows) << 5); }
inline long long shift_se( const long long mask) { return ((mask & all_even_rows) << 5) | ((mask & all_odd_rows) << 6); }
inline long long shift_mask( int direction, const long long mask) {
   switch (direction) {
  case WEST: return shift_west(mask);
  case EAST: return shift_east(mask);
  case SW: return shift_sw(mask);
  case SE: return shift_se(mask);
  case NW: return shift_nw(mask);
   }
   return shift_ne(mask);
}


char const* dir_texts[] =       {"WEST","EAST","SW",  "SE",  "NW",  "NE"  };
int rotation_adder[2][6] = {
   { -1,    1,     4,     5,     -6,    -5   },
   { -1,    1,     5,     6,     -5,    -4   } };

int flip_transform[6] =    { WEST,  EAST,  NW,    NE,    SW,    SE   };
int rotate_transform[6] =  { NW,    SE,    WEST,  SW,    NE,    EAST };
int opposite_transform[6] ={ EAST,  WEST,  NE,    NW,    SE,    SW   };

int two_row_mask = 1024-1;
int bit_counts[32];
int first_bits[32];


typedef struct MaskInfo {
   bool is_legal[2];
   int start;

   MaskInfo() { is_legal[0] = is_legal[1] = true; }
   // bool piece_allowed[10];
};

MaskInfo big_map[1024];

long long flood_fill_actual( long long &mask, const int pos) {
   set_bit(mask, pos);
   if (pos % 5 && !has_bit( mask, pos - 1)) flood_fill_actual( mask, pos - 1);
   if (pos % 5 < 4 && !has_bit( mask, pos + 1)) flood_fill_actual( mask, pos + 1);
   if (pos >= 5) {
      if (!has_bit( mask, pos - 5)) flood_fill_actual( mask, pos - 5);
      if (pos / 10 < 5) {
         if (pos % 5 && !has_bit( mask, mask, pos - 6)) flood_fill_actual( mask, pos - 6);
      } else {
         if (pos % 5 < 4 && !has_bit( mask, mask, pos - 4)) flood_fill_actual( mask, pos - 4);
      }
   }
   if (pos < 45) {
      if (!has_bit( mask, pos + 5)) flood_fill_actual( mask, pos + 5);
      if (pos / 10 < 5) {
         if (pos % 5 && !has_bit( mask, pos + 4)) flood_fill_actual( mask, pos + 4);
      } else {
         if (pos % 5 < 4 && !has_bit( mask, pos + 6)) flood_fill_actual( mask, pos + 6);
      }
   }
   return mask;
}

long long flood_fill_down( long long mask, int row, int col) {
   if (row & row_masks[row]) {
      flood_fill_actual( mask, location_of(row, col));
      return mask;
   }

   while (row < 10 && !(mask & row_masks[row])) {
      mask |= row_masks[row];
      row++;
   }

   if (row < 10) for (int i = row * 5; i < (row + 1) * 5; i++) {
      if (!has_bit( mask, i)) flood_fill_actual( mask, i);
   }
   return mask;
}

long long flood_fill_up( long long mask, int row, int col) {
   if (row & row_masks[row]) {
      flood_fill_actual( mask, location_of(row, col));
      return mask;
   }

   while (row >= 0 && !(mask & row_masks[row])) {
      mask |= row_masks[row];
      row--;
   }

   if (row >= 0) for (int i = row * 5; i < (row + 1) * 5; i++) {
      if (!has_bit( mask, i)) flood_fill_actual( mask, i);
   }
   return mask;
}

typedef struct MaskData {
   long long mask[2];
   int height;
   int min_col[2];
   int max_col[2];

   MaskData() {
      mask[0] = 0;
      mask[1] = 0;
      height = 0;
      min_col[0] = 0;
      min_col[1] = 0;
      max_col[0] = 0;
      max_col[1] = 0;
   }
};

typedef struct RotationData {
   int mask;
   int iMask;
   int cMask;
   int row;
   int positions[5];
   int number;
};

void print_mask( long long mask) {
   for (int row = 0; row < 10; row++) {
      if (row % 2) cout << " ";
      for (int col = 0; col < 5; col++) {
         cout << (get_bit( mask, row, col)?"1":"0") << " ";
      }
      cout << "\n";
   }
   cout << "\n";
}

class LList {
public:
   LList *next;
   LList() { next = NULL; }
};

struct RotationSet {
   int size;
   RotationData rotations[12];

   RotationSet() { size = 0; }

   void add( RotationData &data) { rotations[ size] = data; size++; }
};

class PieceData : public LList {
private:
   void transform( const int matrix [], vector<int> &list ) {
      for (int i = 0; i < list.size(); i++) {
         list[i] = matrix[list[i]];
      }
   }

   int get_offset( vector<int> &directions ) {
      int offset = 0;
      for (int i = 0; i < directions.size(); i++) {
         if (directions[i] == SW || directions[i] == NW || directions[i] == WEST) offset++;
         if (directions[i] == NW || directions[i] == NE) offset += 5;
      }
      return offset;
   }

   MaskData mask_for_directions( vector<int> &directions) {
      MaskData data;

      long long mask = 0;
      int start_offset = get_offset( directions);
      int location = start_offset;
      for (int i = 0; i < directions.size(); i++) {
         set_bit( mask, location);
         int addition = rotation_adder[ (location / 5) % 2 ][ directions[i] ];
         //             int row = location / 5;
         //             int other_row = (location + addition) / 5;
         //             char * error = NULL;
         //             if ((directions[i] == SW || directions[i] == SE) && other_row != row + 1) error = "ERROR moving down!";
         //             if ((directions[i] == NW || directions[i] == NE) && other_row != row - 1) error =  "ERROR moving up!";
         //             if ((directions[i] == EAST || directions[i] == WEST) &&row != other_row) error = "ERROR moving to the side!";
         //             if (error != NULL) {
         //               int opposite = opposite_transform[directions[i]];
         //               if (illegal_move_masks[opposite] & mask) {
         //                  cout << error << " directions = ";
         //                  for (int j = 0; j < directions.size(); j++) cout << dir_texts[directions[j]] << " ";
         //                  cout << " [[[ current direction = " << dir_texts[directions[i]] << "]]]" << " opposite unavailable: " << dir_texts[opposite] << "\n";
         //                  cout << "row = " << row << ", other row = " << other_row <<"\n";
         //                  print_mask( mask);
         //               } else {
         //                  addition = 0;
         //                  mask = shift_mask( opposite, mask);
         //               }
         //             }
         location += addition;
      }
      set_bit( mask, location);

      while (!(mask & top_edge)) {
         if (illegal_move_masks[NW] & mask) {
            if (illegal_move_masks[NE] & mask) cout << "ERROR SHIFTING UPWARD\n";
            else mask = shift_ne(mask);
         } else mask = shift_nw(mask);
      }

      for (int row = 0; mask & row_masks[row]; row++) data.height++;
      while (!(mask & right_edges)) mask = shift_east(mask);
      for (int col_on = 0; !has_bit(mask, 0, col_on); col_on++) data.max_col[0]++;
      while (!(mask & left_edges)) mask = shift_west(mask);
      for (int col_on = 0; !has_bit(mask, 0, col_on); col_on++) data.min_col[0]++;
      data.mask[0] = mask >> data.min_col[0];

      if (mask & illegal_move_masks[SE]) {
         cout << "ERROR SHIFTING DOWNWARD\n";
      } else {
         mask = shift_se( mask);
         while (!(mask & right_edges)) mask = shift_east(mask);
         for (int col_on = 0; !get_bit(mask, 1, col_on); col_on++) data.max_col[1]++;
         while (!(mask & left_edges)) mask = shift_west(mask);
         for (int col_on = 0; !get_bit(mask, 1, col_on); col_on++) data.min_col[1]++;
         data.mask[1] = mask >> (data.min_col[1] + 5);
      }

      //cout << "\nDIRECTIONS: " << directions[0] << directions[1] << directions[2] << directions[3] << " [" << start_offset << "]\n";
      //cout << "height = " << data.height << ", min[0] = " << data.min_col[0] << ", max[0] = " << data.max_col[0] <<
      //   ", min[1] = " << data.min_col[1] << ", max[1] = " << data.max_col[1] << "\n";
      //print_mask( data.mask[1]);
      //exit(0);

      return data;
   }

   void compute_rotation_positions( long long board, RotationData &rotation) {
      int pos = rotation.row * 5;
      for (int num = 0; num < 5; pos++) {
         if (has_bit(board, pos)) {
            rotation.positions[num] = pos;
            num++;
         }
      }
   }

   void add_rotation( long long mask, int row, int col) {
      RotationData rotation;
      rotation.row = row;
      rotation.mask = (int)(mask >> (5 * row));
      rotation.number = number;
      long long board = 0;
      for (int i = 0; i < row; i++) board |= row_masks[i];
      for (int i = 0; i < col; i++) set_bit( board, row, i);
      board |= mask;
      for (int i = 4; i >= 0; i--) {
         if (!has_bit( board, 9, i)) {
            board = flood_fill_up( board, 9, i);
            break;
         }
      }
      if (board == full_mask) {
         rotation.iMask = rotation.mask;
         rotation.cMask = 0;
      } else {
         int count = 0;
         long long cMask = 0;
         for (int pos = location_of(row, col); pos < 50; pos++) {
            if (!has_bit(board,pos)) {
               set_bit(cMask, pos);
               count++;
            }
            if (count >= 5) {
               cMask = 0;
               break;
            }
         }
         rotation.cMask = (int)(cMask >> (5 * row));
         rotation.iMask = rotation.mask | rotation.cMask;
      }

      compute_rotation_positions( mask, rotation);
      rotation_sets[row][col].add( rotation);
   }

   void build_piece( vector<int> &directions) {
      vector<MaskData> base_masks;
      for (int i = 0; i < 2; i++) {
         for (int j = 0; j < 6; j++) {
            base_masks.push_back(mask_for_directions(directions));
            transform( rotate_transform, directions);
         }
         transform( flip_transform, directions);
      }

      for (int mask_on = 0; mask_on < base_masks.size(); mask_on++) {
         MaskData data = base_masks[mask_on];
         for (int row = 0; row <= (10 - data.height); row++) {
            for (int col = data.min_col[row % 2]; col <= data.max_col[row % 2]; col++) {
               long long mask = data.mask[row % 2] << (row * 5 + col);
               long long board = mask;
               if ( row >= 3) board = flood_fill_down( board, 0, 0);
               else board = flood_fill_up( board, 9, 4);
               if (board == full_mask) {
                  add_rotation( mask, row, col);
               } else {
                  int count = 0;
                  for (int t = 0; t < 10; t++) count += bit_counts[ (int)((board >> (t * 5)) & row_masks[0])];
                  if (count % 5 == 0) {
                     add_rotation( mask, row, col);
                  }
               }
            }
         }
      }
   }

public:
   int number;
   RotationSet rotation_sets[10][5];

   PieceData( int d1, int d2, int d3, int d4, int piece_number ) : LList()  {
      number = piece_number;
      vector<int> directions;
      directions.push_back(d1);
      directions.push_back(d2);
      directions.push_back(d3);
      directions.push_back(d4);
      build_piece( directions);
   }

   PieceData( int d1, int d2, int d3, int d4, int d5, int piece_number ) : LList() {
      number = piece_number;
      vector<int> directions;
      directions.push_back(d1);
      directions.push_back(d2);
      directions.push_back(d3);
      directions.push_back(d4);
      directions.push_back(d5);
      build_piece( directions);
   }
};

// GOLBAL VARIABLES MUH-HA-HA-HA
LList *head;
LList *tail;

int num_placed = 0;
int num_found = 0;
int num_to_find = 0;
int tries[10] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
RotationData *active_rotations[10];
set<string> found_boards;

void create_piece_maps() {
   tail = head = new PieceData( NW, NE, EAST, EAST,  2);
   tail->next = new PieceData( NE, SE, EAST, NE,  7);
   tail = tail->next;
   tail->next = new PieceData( NE, EAST, NE, NW,  1);
   tail = tail->next;
   tail->next = new PieceData( EAST, SW, SW, SE,  6);
   tail = tail->next;
   tail->next = new PieceData( EAST, NE, SE, NE,  5);
   tail = tail->next;
   tail->next = new PieceData( EAST, EAST, EAST, SE,  0);
   tail = tail->next;
   tail->next = new PieceData( NE, NW, SE, EAST, SE,  4);
   tail = tail->next;
   tail->next = new PieceData( SE, SE, SE, WEST,  9);
   tail = tail->next;
   tail->next = new PieceData( SE, SE, EAST, SE,  8);
   tail = tail->next;
   tail->next = new PieceData( EAST, EAST, SW, SE,  3);
   tail = tail->next;
}

void print_board( string board_string) {
   for (int row = 0; row < 10; row++) {
      if (row % 2) cout << " ";
      for (int col = 0; col < 5; col++) cout << board_string[row * 5 + col] << " ";
      cout << "\n";
   }
   cout << "\n";
}

void print_results() {
   cout << num_found << " solutions found\n\n";
   print_board( *found_boards.begin());
   print_board( *found_boards.rbegin());
}

void add_board_string( const char * board_string) {
   string s = board_string;
   if (found_boards.count(s) == 0) {
      found_boards.insert(s);
      num_found++;
      if (num_to_find == num_found) {
         print_results();
         exit(0);
      }
   }
}


void board_found() {
   char board_string[51];
   memset(board_string,'x',51);
   for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 5; j++) {
         board_string[active_rotations[i]->positions[j]] = '0' + active_rotations[i]->number;
      }
   }
   board_string[50] = 0;
   add_board_string( board_string);
   for (int i = 0; i < 25; i++) { char c = board_string[i]; board_string[i] = board_string[49 - i]; board_string[49-i] = c; }
   add_board_string( board_string);
}

void find( int row, int board) {
   while ((board & 31) == 31) {
      row++;
      board >>= 5;
   }
   MaskInfo &info = big_map[board & two_row_mask];
   if (!info.is_legal[row % 2]) return;
   int col = info.start;


   PieceData *start = (PieceData *)head;
   do {
      PieceData *piece = (PieceData *)head;
      head = piece->next;
      piece->next = NULL;
      RotationSet *rotations = &(piece->rotation_sets[row][col]);
      for (int i = rotations->size-1; i >= 0; i--) {
         //tries[num_placed]++;
         RotationData *rotation = &rotations->rotations[i];
         if ((board & rotation->iMask) == rotation->cMask) {
            if (num_placed == 9) {
               active_rotations[num_placed] = rotation;
               board_found();
            } else {
               active_rotations[num_placed] = rotation;
               num_placed++;
               find( row, board | rotation->mask);
               num_placed--;
            }
         }
      }
      if (head == NULL) head = piece;
      else tail->next = piece;
      tail = piece;
   } while (start != head);
}

void find_all() {
   num_found = 0;
   num_placed = 1;
   found_boards.clear();
   PieceData *start = (PieceData *)head;
   for (int odd = 0; odd < 2; odd++) {
      do {
         PieceData *piece = (PieceData *)head;
         head = piece->next;
         piece->next = NULL;
         if (head != start) {
            RotationSet *rotations = &(piece->rotation_sets[0][0]);
            for (int i = rotations->size-1; i >= 0; i--) {
               if (i % 2 == odd) {
                  RotationData *rotation = &rotations->rotations[i];
                  active_rotations[0] = rotation;
                  find( 0, rotation->mask);
               }
            }
         }
         if (head == NULL) head = piece;
         else tail->next = piece;
         tail = piece;
      } while (start != head);
   }
}


void create_utlity_maps() {
   for (int i = 0; i < 32; i++) {
      bit_counts[i] = 0;
      for (int j = 0; j < 5; j++) if ((1 << j) & i) bit_counts[i]++;
      for (first_bits[i] = 0; (1 << first_bits[i]) & i; first_bits[i]++);
   }

   // build starts
   for (int i = 0; i < 1024; i++) big_map[i].start = first_bits[i & 31];

   // build legality
   int legal_count = 0;
   for (int i = 0; i < 1024; i++) {
      for (int odd = 0; odd < 2; odd++) {
         int legal = 2;
         int bit = 1;
         while (legal && bit < 32) {
            if (i & bit) {
               if (legal == 2 && bit > 1 && ((bit >> 1) & i) == 0) legal = 0;
               else legal = 2;
            } else if (legal == 2) {
               if (((bit << 5) & i) == 0) legal = 1;
               else {
                  if (odd) {
                     if ( (bit < 16) && (((bit << 6) & i) == 0)) legal = 1;
                  } else {
                     if ( (bit > 1) && (((bit << 4) & i) == 0)) legal = 1;
                  }
               }
            }
            bit <<= 1;
         }
         if (legal == 2 && ((bit >> 1) & i) == 0) legal = 0;
         big_map[i].is_legal[odd] = legal ? true : false;
         if (legal) legal_count++;
      }
   }
}

int main (int argc, char * const argv[]) {
   num_to_find = 2098;
   if (argc > 1) sscanf(argv[1],"%d", &num_to_find);

   create_piece_maps();
   create_utlity_maps();
   find_all();
   print_results();

   return 0;
}

