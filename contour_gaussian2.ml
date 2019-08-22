open Plplot

let pi = acos (-1.0)
let tau = 2.0 *. pi
let pih = 0.5 *. pi
let nx = 120
let ny = 61 
let f = 2.25 /. 3.0

let deg2rad x =
  x *. pi /. 180.

let geodesic_distance lon lat lonc latc =
  let dlon = lon -. lonc in
  acos(sin latc  *. sin lat +. cos latc  *. cos lat  *. cos dlon)

let () =
  let lonc = deg2rad 180. in 
  let latc = deg2rad 0.0 in

  let dx = 360. /. float nx in
  let dy = 180. /. float (ny - 1) in
  let lon = Array.init nx (fun i -> dx *. float i) in
  let lat = Array.init ny (fun j -> 90. -. dy *. float j) in

  let h = Array.make_matrix nx ny 0.0 in
  for i = 0 to nx -1 do
    let loni = deg2rad lon.(i) in
    for j = 0 to ny - 1 do
      let latj = deg2rad lat.(j) in
      let r = f *. geodesic_distance loni latj lonc latc in
      h.(i).(j) <- exp(-.r *. r)
    done
  done;

  let lev = Array.init 10 (fun i -> 0.1 *. float i) in
  (* parse command-line options *)
  plparseopts Sys.argv [PL_PARSE_FULL];
  plinit ();
  (* sequence of commands instead of plenv for custom ticks *)
  pladv 0;
  plvsta ();
  plwind 0. 360. ~-.90. 90.;
  plbox "bcnst" 60. 0 "bcnst" 30. 0;
  (* *)
  plset_pltr (pltr1 lon lat);
  plcont h 1 nx 1 ny lev;
  plend ();
  ()
