// Template mesh geometry file for a single inclusion on two slabs.
// Inclusion can be circular, elliptical square, or rectangular.

d = 1; // grating period
ff = 0;
d_in_nm = 100;
dy_in_nm = 50;
dy = dy_in_nm/d_in_nm;
a1 = 70;
a1y = 10;
radius1 = (a1/(2*d_in_nm))*d;
radius1y = (a1y/(2*d_in_nm))*d;

rect = 1;

slab_width = 40;
slab_height = 5;
slab_w = slab_width/d_in_nm;
slab_h = slab_height/d_in_nm;
slab_w_full = 0;
If(slab_w == 1)
    slab_w_full = 1;
EndIf

slab2_width = 20;
slab2_height = 10;
slab2_w = slab2_width/d_in_nm;
slab2_h = slab2_height/d_in_nm;
slab2_w_full = 0;
If(slab2_w == 1)
    slab2_w_full = 1;
EndIf

lc = 0; // 0.501 0.201 0.0701;
lc2 = lc/1; // on cylinder surfaces
lc3 = lc/1; // cylinder1 centres
lc4 = lc/1; // centres of top and bottom
lc5 = lc/1; // slab

hy = dy; // Thickness: square profile => hy=d
hx = 0.;


Point(1) = {0, 0, 0, lc};
Point(2) = {-hx, -hy, 0, lc};
Point(3) = {-hx+d, -hy, 0, lc};
Point(4) = {d, 0, 0,lc};

// Slab
Point(250) = {d/2-slab_w/2, -hy+slab_h+slab2_h, 0, lc5};
Point(251) = {d/2+slab_w/2, -hy+slab_h+slab2_h, 0, lc5};
Point(350) = {d/2-slab2_w/2, -hy+slab2_h, 0, lc5};
Point(351) = {d/2+slab2_w/2, -hy+slab2_h, 0, lc5};

// Inclusion
Point(5) = {-hx+d/2, -hy+radius1y+slab_h+slab2_h, 0, lc3};
Point(6) = {-hx+d/2, -hy+2*radius1y+slab_h+slab2_h, 0, lc2};
Point(7) = {-hx+d/2-radius1, -hy+radius1y+slab_h+slab2_h, 0, lc2};
Point(8) = {-hx+d/2, -hy+slab_h+slab2_h, 0, lc2};
Point(9) = {-hx+d/2+radius1, -hy+radius1y+slab_h+slab2_h, 0, lc2};
Point(38) = {-hx+d/2, -hy+slab2_h, 0, lc2};

Point(10) = {-hx+d/2, 0, 0, lc4};
Point(11) = {0,-hy+radius1y+slab_h+slab2_h, 0, lc};
Point(12) = {-hx+d/2, -hy, 0, lc4};
Point(13) = {d, -hy+radius1y+slab_h+slab2_h, 0, lc};
Line(1) = {1,10};
Line(2) = {10,4};
Line(5) = {1,11};
Line(7) = {4,13};
Line(9) = {11,7};
Line(10) = {7,5};
Line(11) = {5,9};
Line(12) = {9,13};
Line(13) = {10,6};
Line(14) = {6,5};
Line(15) = {5,8};


If(rect == 0)
    Ellipsis(17) = {9,5,6,6};
    Ellipsis(18) = {6,5,7,7};
    Ellipsis(19) = {7,5,8,8};
    Ellipsis(20) = {8,5,9,9};

    If(slab_w_full == 1)
        Line(6) = {11,250};
        Line(8) = {13,251};
        Line(21) = {2, 250};
        Line(22) = {250, 8};
        Line(23) = {8, 251};
        Line(24) = {251, 3};
        Line(25) = {3, 12};
        Line(26) = {12, 2};

    EndIf

    If(slab_w_full == 0)
        Line(21) = {252, 250};
        Line(22) = {250, 8};
        Line(23) = {8, 251};
        Line(24) = {251, 253};
        Line(25) = {253, 12};
        Line(26) = {12, 252};


    EndIf
EndIf


If(rect == 1)
    Point(150) = {-hx+d/2+radius1, -hy+slab_h+slab2_h+2*radius1y, 0,lc3};
    Point(151) = {-hx+d/2-radius1, -hy+slab_h+slab2_h+2*radius1y, 0,lc3};
    Point(152) = {-hx+d/2+radius1, -hy+slab_h+slab2_h, 0,lc3};
    Point(153) = {-hx+d/2-radius1, -hy+slab_h+slab2_h, 0,lc3};

    If(slab_w_full == 1)
        Line(6) = {11,250};
        Line(8) = {13,251};
        Line(27) = {153, 8};
        Line(28) = {8, 152};
        Line(29) = {153, 7};
        Line(30) = {7, 151};
        Line(31) = {151, 6};
        Line(32) = {6, 150};
        Line(33) = {150, 9};
        Line(34) = {9, 152};

        If(slab2_w_full == 1)
            Line(22) = {250, 153};
            Line(23) = {152, 251};     
            Line(25) = {3, 12};
            Line(26) = {12, 2};   
            Line(35) = {350, 2};
            Line(36) = {350, 250};
            Line(37) = {8, 38};
            Line(38) = {38, 12};
            Line(39) = {351, 3};
            Line(40) = {351, 251};
            Line(41) = {350, 38};
            Line(42) = {38, 351};

            Line Loop(43) = {5, 9, 30, 31, -13, -1};
            Plane Surface(44) = {43};
            Line Loop(45) = {13, 32, 33, 12, -7, -2};
            Plane Surface(46) = {45};
            Line Loop(47) = {12, 8, -23, -34};
            Plane Surface(48) = {47};
            Line Loop(49) = {29, -9, 6, 22};
            Plane Surface(50) = {49};
            Line Loop(51) = {29, 10, 15, -27};
            Plane Surface(52) = {51};
            Line Loop(53) = {15, 28, -34, -11};
            Plane Surface(54) = {53};
            Line Loop(55) = {11, -33, -32, 14};
            Plane Surface(56) = {55};
            Line Loop(57) = {31, 14, -10, 30};
            Plane Surface(58) = {57};
            Line Loop(59) = {22, 27, 37, -41, 36};
            Line Loop(60) = {37, 42, 40, -23, -28};
            Plane Surface(61) = {60};
            Plane Surface(62) = {59};
            Line Loop(63) = {41, 38, 26, -35};
            Plane Surface(64) = {63};
            Line Loop(65) = {38, -25, -39, -42};
            Plane Surface(66) = {65};

            Physical Line(67) = {5, 6, 36, 35};
            Physical Line(68) = {26, 25};
            Physical Line(69) = {39, 40, 8, 7};
            Physical Line(70) = {2, 1};

            Physical Surface(1) = {44, 46, 48, 50};
            Physical Surface(2) = {58, 56, 54, 52};
            Physical Surface(3) = {62, 61};
            Physical Surface(4) = {66, 64};
        EndIf

        If(slab2_w_full == 0)
            Point(352) = {d/2-slab2_w/2, -hy+slab_h+slab2_h, 0, lc5};
            Point(353) = {d/2+slab2_w/2, -hy+slab_h+slab2_h, 0, lc5};
            Point(354) = {d/2-slab2_w/2, -hy, 0, lc5};
            Point(355) = {d/2+slab2_w/2, -hy, 0, lc5};
            Point(356) = {d/2-slab_w/2, -hy+slab2_h, 0, lc5};
            Point(357) = {d/2+slab_w/2, -hy+slab2_h, 0, lc5};

            Line(37) = {8, 38};
            Line(38) = {38, 12};
            Line(41) = {350, 38};
            Line(42) = {38, 351};
            Line(43) = {356, 250};
            Line(44) = {356, 2};
            Line(45) = {2, 354};
            Line(46) = {354, 12};
            Line(47) = {12, 355};
            Line(48) = {355, 3};
            Line(49) = {3, 357};
            Line(50) = {357, 251};
            Line(51) = {351, 355};
            Line(52) = {351, 357};
            Line(53) = {353, 251};
            Line(54) = {353, 152};
            Line(55) = {153, 352};
            Line(56) = {352, 250};
            Line(57) = {356, 350};
            Line(58) = {350, 354};
            
            Line Loop(43) = {5, 9, 30, 31, -13, -1};
            Plane Surface(44) = {43};
            Line Loop(45) = {13, 32, 33, 12, -7, -2};
            Plane Surface(46) = {45};
            Line Loop(59) = {12, 8, -53, 54, -34};
            Plane Surface(60) = {59};
            Line Loop(61) = {29, -9, 6, -56, -55};
            Plane Surface(62) = {61};
            Line Loop(63) = {29, 10, 15, -27};
            Plane Surface(64) = {63};
            Line Loop(65) = {15, 28, -34, -11};
            Plane Surface(66) = {65};
            Line Loop(67) = {33, -11, -14, 32};
            Plane Surface(68) = {67};
            Line Loop(69) = {14, -10, 30, 31};
            Plane Surface(70) = {69};
            Line Loop(71) = {28, -54, 53, -50, -52, -42, -37};
            Plane Surface(72) = {71};
            Line Loop(73) = {37, -41, -57, 43, -56, -55, 27};
            Plane Surface(74) = {73};
            Line Loop(75) = {41, 38, -46, -58};
            Plane Surface(76) = {75};
            Line Loop(77) = {38, 47, -51, -42};
            Plane Surface(78) = {77};
            Line Loop(79) = {51, 48, 49, -52};
            Plane Surface(80) = {79};
            Line Loop(81) = {58, -45, -44, 57};
            Plane Surface(82) = {81};

            Physical Line(83) = {5, 6, 43, 44};
            Physical Line(84) = {45, 46, 47, 48};
            Physical Line(85) = {49, 50, 8, 7};
            Physical Line(86) = {2, 1};

            Physical Surface(1) = {44, 62, 60, 46};
            Physical Surface(2) = {68, 70, 64, 66};
            Physical Surface(3) = {72, 74};
            Physical Surface(4) = {76, 78};
            Physical Surface(5) = {80, 82};
        EndIf
    EndIf

    If(slab_w_full == 0)
        Point(354) = {d/2-slab2_w/2, -hy, 0, lc5};
        Point(355) = {d/2+slab2_w/2, -hy, 0, lc5};
        Point(356) = {d/2-slab_w/2, -hy+slab2_h, 0, lc5};
        Point(357) = {d/2+slab_w/2, -hy+slab2_h, 0, lc5};

        Line(17) = {151, 6};
        Line(18) = {6, 150};
        Line(19) = {150, 9};
        Line(20) = {9, 152};
        Line(23) = {153, 7};
        Line(24) = {7, 151};
        Line(26) = {153, 250};
        Line(30) = {251, 152};

        If(2*radius1 < slab_w)
            If(slab2_w_full == 1)
                Point(352) = {d/2-slab2_w/2, -hy+slab_h+slab2_h, 0, lc5};
                Point(353) = {d/2+slab2_w/2, -hy+slab_h+slab2_h, 0, lc5};
                Line(21) = {152, 8};
                Line(22) = {8, 153};
                Line(31) = {11, 352};
                Line(32) = {352, 250};
                Line(33) = {352, 350};
                Line(34) = {350, 356};
                Line(35) = {350, 2};
                Line(36) = {2, 12};
                Line(37) = {12, 3};
                Line(38) = {3, 351};
                Line(39) = {351, 353};
                Line(40) = {353, 13};
                Line(41) = {353, 251};
                Line(42) = {251, 357};
                Line(43) = {357, 351};
                Line(44) = {357, 38};
                Line(45) = {38, 356};
                Line(46) = {250, 356};
                Line(47) = {38, 12};
                Line(48) = {8, 38};

                Line Loop(49) = {5, 9, 24, 17, -13, -1};
                Plane Surface(50) = {49};
                Line Loop(51) = {13, 18, 19, 12, -7, -2};
                Plane Surface(52) = {51};
                Line Loop(53) = {12, -40, 41, 30, -20};
                Plane Surface(54) = {53};
                Line Loop(55) = {23, -9, 31, 32, -26};
                Plane Surface(56) = {55};
                Line Loop(57) = {17, 14, -10, 24};
                Plane Surface(58) = {57};
                Line Loop(59) = {18, 19, -11, -14};
                Line Loop(60) = {23, 10, 15, 22};
                Plane Surface(61) = {60};
                Line Loop(62) = {15, -21, -20, -11};
                Plane Surface(63) = {62};
                Plane Surface(64) = {59};
                Line Loop(65) = {30, 21, 48, -44, -42};
                Plane Surface(66) = {65};
                Line Loop(67) = {48, 45, -46, -26, -22};
                Plane Surface(68) = {67};
                Line Loop(69) = {41, 42, 43, 39};
                Plane Surface(70) = {69};
                Line Loop(71) = {46, -34, -33, 32};
                Plane Surface(72) = {71};
                Line Loop(73) = {34, -45, 47, -36, -35};
                Plane Surface(74) = {73};
                Line Loop(75) = {47, 37, 38, -43, 44};
                Plane Surface(76) = {75};

                Physical Line(77) = {5, 31, 33, 35};
                Physical Line(78) = {36, 37};
                Physical Line(79) = {7, 40, 39, 38};
                Physical Line(80) = {2, 1};

                Physical Surface(1) = {50, 52, 54, 56};
                Physical Surface(2) = {58, 64, 63, 61};
                Physical Surface(3) = {66, 68};
                Physical Surface(4) = {72, 70};
                Physical Surface(5) = {76, 74};
            EndIf

            If(slab2_w_full == 0)
                Point(358) = {d/2-slab_w/2, -hy, 0, lc5};
                Point(359) = {d/2+slab_w/2, -hy, 0, lc5};
                Point(360) = {0, -hy+slab2_h, 0, lc5};
                Point(361) = {d, -hy+slab2_h, 0, lc5};
                Point(362) = {0, -hy+slab_h+slab2_h, 0, lc5};
                Point(363) = {d, -hy+slab_h+slab2_h, 0, lc5};
                Line(31) = {11, 362};
                Line(32) = {362, 360};
                Line(33) = {360, 2};
                Line(36) = {354, 12};
                Line(38) = {355, 359};
                Line(40) = {3, 361};
                Line(41) = {361, 363};
                Line(42) = {363, 13};
                Line(45) = {356, 350};
                Line(46) = {351, 357};
                Line(47) = {8, 38};
                Line(48) = {38, 12};

                If(slab2_w > slab_w)
                    Line(34) = {2, 354};
                    Line(35) = {358, 354};
                    Line(37) = {12, 359};
                    Line(39) = {355, 3};
                    Line(53) = {153, 8};
                    Line(54) = {8, 152};
                    Line(55) = {251, 363};
                    Line(56) = {251, 357};
                    Line(57) = {351, 361};
                    Line(58) = {351, 355};
                    Line(59) = {357, 38};
                    Line(60) = {356, 38};
                    Line(61) = {350, 354};
                    Line(62) = {362, 250};
                    Line(63) = {250, 356};
                    Line(64) = {360, 350};
                                    
                    Line Loop(65) = {5, 9, 24, 17, -13, -1};
                    Plane Surface(66) = {65};
                    Line Loop(67) = {13, 18, 19, 12, -7, -2};
                    Plane Surface(68) = {67};
                    Line Loop(69) = {12, -42, -55, 30, -20};
                    Plane Surface(70) = {69};
                    Line Loop(71) = {23, -9, 31, 62, -26};
                    Plane Surface(72) = {71};
                    Line Loop(73) = {23, 10, 15, -53};
                    Plane Surface(74) = {73};
                    Line Loop(75) = {15, 54, -20, -11};
                    Plane Surface(76) = {75};
                    Line Loop(77) = {11, -19, -18, 14};
                    Plane Surface(78) = {77};
                    Line Loop(79) = {14, -10, 24, 17};
                    Plane Surface(80) = {79};
                    Line Loop(81) = {62, 63, 45, -64, -32};
                    Plane Surface(82) = {81};
                    Line Loop(83) = {63, 60, -47, -53, 26};
                    Plane Surface(84) = {83};
                    Line Loop(85) = {47, -59, -56, 30, -54};
                    Plane Surface(86) = {85};
                    Line Loop(87) = {56, -46, 57, 41, -55};
                    Plane Surface(88) = {87};
                    Line Loop(93) = {64, 61, -34, -33};
                    Plane Surface(94) = {93};
                    Line Loop(95) = {61, 36, -48, -60, 45};
                    Plane Surface(96) = {95};
                    Line Loop(97) = {59, 48, 37, -38, -58, 46};
                    Plane Surface(98) = {97};
                    Line Loop(105) = {58, 39, 40, -57};
                    Plane Surface(106) = {105};

                    Physical Line(49) = {1, 2};
                    Physical Line(50) = {7, 42, 41, 40};
                    Physical Line(52) = {33, 32, 31, 5};
                    Physical Line(107) = {34, 35, 36, 37, 38, 39};

                    Physical Surface(1) = {66, 68, 70, 72};
                    Physical Surface(2) = {80, 78, 76, 74};
                    Physical Surface(3) = {84, 86};
                    Physical Surface(4) = {88, 82};
                    Physical Surface(5) = {96, 98};
                    Physical Surface(6) = {106, 94};
                EndIf

                If(slab2_w < slab_w)
                    Line(49) = {362, 250};
                    Line(50) = {356, 360};
                    Line(51) = {350, 38};
                    Line(52) = {350, 354};
                    Line(53) = {351, 355};
                    Line(54) = {351, 38};
                    Line(55) = {8, 152};
                    Line(56) = {8, 153};
                    Line(57) = {251, 363};
                    Line(58) = {361, 357};
                    Line(59) = {251, 357};
                    Line(60) = {250, 356};
                    Line(61) = {358, 354};
                    Line(62) = {358, 2};
                    Line(63) = {12, 355};
                    Line(64) = {359, 3};

                    Line Loop(65) = {5, 9, 24, 17, -13, -1};
                    Plane Surface(66) = {65};
                    Line Loop(67) = {13, 18, 19, 12, -7, -2};
                    Plane Surface(68) = {67};
                    Line Loop(69) = {12, -42, -57, 30, -20};
                    Plane Surface(70) = {69};
                    Line Loop(71) = {23, -9, 31, 49, -26};
                    Plane Surface(72) = {71};
                    Line Loop(73) = {23, 10, 15, 56};
                    Plane Surface(74) = {73};
                    Line Loop(75) = {10, -14, -17, -24};
                    Plane Surface(76) = {75};
                    Line Loop(77) = {14, 11, -19, -18};
                    Plane Surface(78) = {77};
                    Line Loop(79) = {11, 20, -55, -15};
                    Plane Surface(80) = {79};
                    Line Loop(81) = {30, -55, 47, -54, 46, -59};
                    Plane Surface(82) = {81};
                    Line Loop(83) = {47, -51, -45, -60, -26, -56};
                    Plane Surface(84) = {83};
                    Line Loop(85) = {60, 50, -32, 49};
                    Plane Surface(86) = {85};
                    Line Loop(87) = {59, -58, 41, -57};
                    Plane Surface(88) = {87};
                    Line Loop(89) = {58, -46, 53, 38, 64, 40};
                    Plane Surface(90) = {89};
                    Line Loop(91) = {50, 33, -62, 61, -52, -45};
                    Plane Surface(92) = {91};
                    Line Loop(93) = {52, 36, -48, -51};
                    Plane Surface(94) = {93};
                    Line Loop(95) = {48, 63, -53, 54};
                    Plane Surface(96) = {95};

                    Physical Line(97) = {62, 61, 36, 63, 38, 64};
                    Physical Line(98) = {40, 41, 42, 7};
                    Physical Line(99) = {1, 2};
                    Physical Line(100) = {5, 31, 32, 33};

                    Physical Surface(1) = {66, 68, 70, 72};
                    Physical Surface(2) = {76, 78, 80, 74};
                    Physical Surface(3) = {84, 82};
                    Physical Surface(4) = {86, 88};
                    Physical Surface(5) = {96, 94};
                    Physical Surface(6) = {92, 90};
                EndIf
            EndIf
        EndIf

        If(2*radius1 > slab_w)
            If(slab2_w_full == 1)
                Point(352) = {d/2-slab2_w/2, -hy+slab_h+slab2_h, 0, lc5};
                Point(353) = {d/2+slab2_w/2, -hy+slab_h+slab2_h, 0, lc5};
                Line(31) = {11, 352};
                Line(32) = {352, 250};
                Line(33) = {352, 350};
                Line(34) = {350, 356};
                Line(35) = {350, 2};
                Line(36) = {2, 12};
                Line(37) = {12, 3};
                Line(38) = {3, 351};
                Line(39) = {351, 353};
                Line(40) = {353, 13};
                Line(41) = {353, 251};
                Line(42) = {251, 357};
                Line(43) = {357, 351};
                Line(44) = {357, 38};
                Line(45) = {38, 356};
                Line(46) = {250, 356};
                Line(47) = {38, 12};
                Line(48) = {8, 38};
                Line(81) = {250, 8};
                Line(82) = {8, 251};

                Line Loop(49) = {5, 9, 24, 17, -13, -1};
                Plane Surface(50) = {49};
                Line Loop(51) = {13, 18, 19, 12, -7, -2};
                Plane Surface(52) = {51};
                Line Loop(53) = {12, -40, 41, 30, -20};
                Plane Surface(54) = {53};
                Line Loop(55) = {23, -9, 31, 32, -26};
                Plane Surface(56) = {55};
                Line Loop(57) = {17, 14, -10, 24};
                Plane Surface(58) = {57};
                Line Loop(59) = {18, 19, -11, -14};
                Plane Surface(64) = {59};
                Line Loop(69) = {41, 42, 43, 39};
                Plane Surface(70) = {69};
                Line Loop(71) = {46, -34, -33, 32};
                Plane Surface(72) = {71};
                Line Loop(73) = {34, -45, 47, -36, -35};
                Plane Surface(74) = {73};
                Line Loop(75) = {47, 37, 38, -43, 44};
                Plane Surface(76) = {75};
                Line Loop(83) = {23, 10, 15, -81, -26};
                Plane Surface(84) = {83};
                Line Loop(85) = {15, 82, 30, -20, -11};
                Plane Surface(86) = {85};
                Line Loop(87) = {82, 42, 44, -48};
                Plane Surface(88) = {87};
                Line Loop(89) = {48, 45, -46, 81};
                Plane Surface(90) = {89};

                Physical Line(77) = {5, 31, 33, 35};
                Physical Line(78) = {36, 37};
                Physical Line(79) = {7, 40, 39, 38};
                Physical Line(80) = {2, 1};

                Physical Surface(1) = {50, 52, 54, 56};
                Physical Surface(2) = {58, 64, 84, 86};
                Physical Surface(3) = {90, 88};
                Physical Surface(4) = {72, 70};
                Physical Surface(5) = {76, 74};
            EndIf

            If(slab2_w_full == 0)
                Point(358) = {d/2-slab_w/2, -hy, 0, lc5};
                Point(359) = {d/2+slab_w/2, -hy, 0, lc5};
                Point(360) = {0, -hy+slab2_h, 0, lc5};
                Point(361) = {d, -hy+slab2_h, 0, lc5};
                Point(362) = {0, -hy+slab_h+slab2_h, 0, lc5};
                Point(363) = {d, -hy+slab_h+slab2_h, 0, lc5};
                Line(31) = {11, 362};
                Line(32) = {362, 360};
                Line(33) = {360, 2};
                Line(36) = {354, 358};
                Line(38) = {355, 359};
                Line(40) = {3, 361};
                Line(41) = {361, 363};
                Line(42) = {363, 13};
                Line(45) = {356, 350};
                Line(46) = {351, 357};
                Line(47) = {8, 38};
                Line(48) = {38, 12};

                If(slab2_w > slab_w)
                    Line(49) = {362, 153};
                    Line(50) = {250, 8};
                    Line(51) = {8, 251};
                    Line(52) = {152, 363};
                    Line(53) = {361, 351};
                    Line(54) = {351, 355};
                    Line(55) = {355, 3};
                    Line(56) = {357, 251};
                    Line(57) = {357, 38};
                    Line(58) = {12, 359};
                    Line(59) = {12, 358};
                    Line(60) = {350, 354};
                    Line(61) = {356, 250};
                    Line(62) = {38, 356};
                    Line(63) = {350, 360};
                    Line(64) = {2, 354};

                    Line Loop(65) = {5, 9, 24, 17, -13, -1};
                    Plane Surface(66) = {65};
                    Line Loop(67) = {13, 18, 19, 12, -7, -2};
                    Plane Surface(68) = {67};
                    Line Loop(69) = {12, -42, -52, -20};
                    Plane Surface(70) = {69};
                    Line Loop(71) = {20, -30, -51, -15, 11};
                    Plane Surface(72) = {71};
                    Line Loop(73) = {11, -19, -18, 14};
                    Plane Surface(74) = {73};
                    Line Loop(75) = {14, -10, 24, 17};
                    Plane Surface(76) = {75};
                    Line Loop(77) = {10, 15, -50, -26, 23};
                    Plane Surface(78) = {77};
                    Line Loop(79) = {23, -9, 31, 49};
                    Plane Surface(80) = {79};
                    Line Loop(81) = {49, 26, -61, 45, 63, -32};
                    Plane Surface(82) = {81};
                    Line Loop(83) = {30, 52, -41, 53, 46, 56};
                    Plane Surface(84) = {83};
                    Line Loop(85) = {56, -51, 47, -57};
                    Plane Surface(86) = {85};
                    Line Loop(87) = {47, 62, 61, 50};
                    Plane Surface(88) = {87};
                    Line Loop(89) = {62, 45, 60, 36, -59, -48};
                    Plane Surface(90) = {89};
                    Line Loop(91) = {48, 58, -38, -54, 46, 57};
                    Plane Surface(92) = {91};
                    Line Loop(93) = {54, 55, 40, 53};
                    Plane Surface(94) = {93};
                    Line Loop(95) = {60, -64, -33, -63};
                    Plane Surface(96) = {95};

                    Physical Line(97) = {64, 36, 59, 58, 38, 55};
                    Physical Line(98) = {5, 31, 32, 33};
                    Physical Line(99) = {1, 2};
                    Physical Line(100) = {7, 42, 41, 40};

                    Physical Surface(1) = {66, 68, 70, 80};
                    Physical Surface(2) = {76, 74, 72, 78};
                    Physical Surface(3) = {88, 86};
                    Physical Surface(4) = {84, 82};
                    Physical Surface(5) = {90, 92};
                    Physical Surface(6) = {96, 94};
                EndIf

                If(slab2_w < slab_w)
                    Line(49) = {350, 354};
                    Line(50) = {354, 12};
                    Line(51) = {12, 355};
                    Line(52) = {351, 355};
                    Line(53) = {351, 38};
                    Line(54) = {38, 350};
                    Line(55) = {356, 360};
                    Line(56) = {2, 358};
                    Line(57) = {359, 3};
                    Line(58) = {361, 357};
                    Line(59) = {357, 251};
                    Line(60) = {251, 8};
                    Line(61) = {8, 250};
                    Line(62) = {250, 356};
                    Line(63) = {153, 362};
                    Line(64) = {152, 363};

                    Line Loop(65) = {5, 9, 24, 17, -13, -1};
                    Plane Surface(66) = {65};
                    Line Loop(67) = {13, 18, 19, 12, -7, -2};
                    Plane Surface(68) = {67};
                    Line Loop(69) = {12, -42, -64, -20};
                    Plane Surface(70) = {69};
                    Line Loop(71) = {9, -23, 63, -31};
                    Plane Surface(72) = {71};
                    Line Loop(73) = {10, -14, -17, -24};
                    Plane Surface(74) = {73};
                    Line Loop(75) = {14, 11, -19, -18};
                    Plane Surface(76) = {75};
                    Line Loop(77) = {11, 20, -30, 60, -15};
                    Plane Surface(78) = {77};
                    Line Loop(79) = {15, 61, -26, 23, 10};
                    Plane Surface(80) = {79};
                    Line Loop(81) = {47, -53, 46, 59, 60};
                    Plane Surface(82) = {81};
                    Line Loop(83) = {47, 54, -45, -62, -61};
                    Plane Surface(84) = {83};
                    Line Loop(85) = {62, 55, -32, -63, 26};
                    Plane Surface(86) = {85};
                    Line Loop(87) = {55, 33, 56, -36, -49, -45};
                    Plane Surface(88) = {87};
                    Line Loop(89) = {49, 50, -48, 54};
                    Plane Surface(90) = {89};
                    Line Loop(91) = {48, 51, -52, 53};
                    Plane Surface(92) = {91};
                    Line Loop(93) = {52, 38, 57, 40, 58, -46};
                    Line Loop(94) = {30, 64, -41, 58, 59};
                    Plane Surface(95) = {94};
                    Plane Surface(96) = {93};

                    Physical Line(97) = {56, 36, 50, 51, 38, 57};
                    Physical Line(98) = {40, 41, 42, 7};
                    Physical Line(99) = {2, 1};
                    Physical Line(100) = {5, 31, 32, 33};

                    Physical Surface(1) = {66, 68, 70, 72};
                    Physical Surface(2) = {74, 80, 78, 76};
                    Physical Surface(3) = {82, 84};
                    Physical Surface(4) = {86, 95};
                    Physical Surface(5) = {92, 90};
                    Physical Surface(6) = {96, 88};
                EndIf
            EndIf

        EndIf

    EndIf
EndIf

// CURRENTLY HERE

