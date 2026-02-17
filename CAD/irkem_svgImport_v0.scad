//import("/Users/rkmoore/Documents/openscad/TwinCl/laser_cut_files/irkem_anvilAlgn_v2");

// Define the height for the 3D object
logo_height = 3;

// Use linear_extrude to give the imported 2D shape a third dimension
linear_extrude(height = logo_height) {
    // Import the SVG file
    import(file = "/Users/rkmoore/Documents/openscad/TwinCl/laser_cut_files/irkem_anvilAlgn_v2.svg",center = true);
}
