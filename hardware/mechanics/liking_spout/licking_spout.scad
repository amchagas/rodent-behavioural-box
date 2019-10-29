///////////////////////////////////////////
// Design for a liking spout to be used  //
// in the behaviour box                  //
//  CC-BY-SA 4.0 20191008                //
//  Andre Maia Chagas                    //
///////////////////////////////////////////

// all dimensions in mm.

//needs the ring.scad file (saved on the same folder)
use <ring.scad>

//// variables /////////////

//needle used as licking spout
needlediameter = 1.53;

//back plate dimensions 
//(the plate that slides on the metal railings)
backpanelx = 70;
backpanely = 48;
backpanelz = 2.5;

supportw=5;

//dimensions for the headport 
//(a "negative" space where the licking spout will be placed)
headportx = 30;
headporty = 20;
headportz = 30;
lickspoutoffset = 5;
//wall thickness
headportwall = 2;


//force sensor dimensions
forcesensord = 18.3;
forcesensorh = 0.8;
forcesensorl = 33; //how long the long part of the sensor
forcesensorw = 8; // wiidth of the long part of the sensor

//infrared led dimensions
irrecd = 3;
irrech = 5;
irledd = 5;
irledh = 9;

//nut & screw infor
screwd = 3.2;
nutd = 5;

/* change this depending on the printer and printer settings
   it is a "tolerance" variable, so holes and fittings can be 
   adjusted.
*/
tol = 0.1;

$fn=30;
//%cube([backpanelx,backpanely,backpanelz]);


//supporting modules
module irholes(){
    rotate([90,0,0]){
        translate([0,0,0]){
            cylinder(d=irledd+2*tol,h=irledh);
        }//end translate
        translate([0,0,-headporty]){    
            cylinder(d=irrecd+2*tol,h=irledh);
        }//end translate
     }//end rotate
}//end module ir holes

module irsupports(){
rotate([90,0,0]){
    translate([0,0,headportwall]){
ring(irledd+2*tol,2,irledh);
    }//end translate
translate([0,0,-headporty+headportwall/2]){    
    ring(irrecd+2*tol,2,irrech);
    }//end translate
}//end rotate
}//end module ir holes



module fsensorholder(){
difference(){
union(){
    cylinder(d=forcesensord+2*tol+headportwall,h=forcesensorh+headportwall/2);
    translate([-4.5,-13,-2]){
        cube([forcesensorw+headportwall,forcesensord+5,forcesensorh+headportwall/2+2]);
    }//end translate
}//end union

union(){
    translate([0,0,forcesensorh/2+headportwall/2]){
        cylinder(d=forcesensord+2*tol,h=forcesensorh);
    }//end translate
    translate([(-forcesensorw+headportwall/2)/2,0,(forcesensorh+headportwall)/2]){
        cube([forcesensorw+2*tol,forcesensorl+headportwall,5]);
    }//end translate
    translate([needlediameter/2,headporty/2+2,needlediameter/4+headportwall/2]){
        rotate([90,0,0]){
            cylinder(d=needlediameter+2*tol,h=55);
        }//end rotate
    }//end translate
}//end union

}//end difference

}//end module



/////////////////////////////
module needlesupport(){
    module mainframe(){
difference(){
cube([8+2*headportwall,forcesensorw+2*headportwall,35+2*headportwall]);
translate([headportwall,-headportwall,headportwall]){
cube([8,forcesensorw+4*headportwall,28]);
}//end translate
}//end difference
translate([headportwall,0,5]){
cube([8,forcesensorw+2*headportwall,headportwall]);
}//end translate
}//end submodule

difference(){
mainframe();
//translate([13.5,(forcesensorw+2*headportwall)/2,12]){
//rotate([0,90,0]){    
//%cylinder(d=nutd+2*tol,h=4,$fn=6);
//    translate([0,0,-6]){
//cylinder(d=screwd,h=12);
//}//rotate
//}//translate
//cube([nutd,nutd+10,nutd+tol],center=true);
//}//translate
translate([irrecd/2+2*headportwall,(forcesensorw+2*headportwall)/2,-headportwall-1]){
    rotate([0,0,0]){
        %cylinder(d=needlediameter+2*tol,h=20);
    }//end rotate
    translate([0,0,35+headportwall]){
    rotate([90,0,0]){
        
        cylinder(d=irledd+2*tol,h=20);
        
    }//end rotate
    rotate([-90,0,0]){
        
        cylinder(d=irrecd+2*tol,h=20);
        
    }//end rotate
    }//end translate
}//end translate



translate([headportwall,headportwall,10]){
        cube([8,forcesensorw,30]);
        
    }//end translate
    
}//end difference
translate([(8+headportwall)/2+0.5,0,35+headportwall-irledd/2-0.5]){
rotate([90,0,0]){
ring(irledd+2*tol,2,irledh);
}//end rotate
}//end translate
translate([(8+headportwall)/2+0.5,forcesensorw+2*headportwall,35+headportwall-irrecd]){
rotate([-90,0,0]){
ring(irrecd+2*tol,2,irrech);

}//end rotate
}//end translate
//}//end translate
}//end module




/////////////////////////////
module lickingport(){
//head port
difference(){
cube([headportx,headporty,headportz]);
    
    
union(){    
translate([headportwall,headportwall,headportwall]){
cube([headportx-headportwall*2,headporty-headportwall*2,headportz]);
}//end translate


//needle entry
translate([headportx/5+lickspoutoffset-needlediameter/2,(headporty-headportwall+needlediameter)/2,-35]){
    cylinder(d=3*needlediameter+2*tol,h=50);
    }//end translate
 
    //led side ports
    translate([headportx/5+5,headportwall+2,4*headportz/5]){
        irholes();
    }//end translate
}//end union
}//end difference
///////////////////////

////////////////////////////
    
///////////////////////////
//base plate with round liquid reservoir


difference(){ 
cube([headportx/5,headporty,headportz]);
translate([headportx/5,headporty/2,3*headportz/6]){
    sphere(d=12);
    }//end translate
}//end difference
    
////////////////////////////

translate([headportx/5+5,headportwall+2,4*headportz/5]){
irsupports();
}
}//end licking port


module backpanel(){
difference(){
translate([-(headportx+2*headportwall)/2,-headporty/2-headportwall-1,headportz-headportwall-0.5]){

cube([backpanelx,backpanely,backpanelz]);
    

}
translate([0,0,5]){
cube([headportx,headporty,headportz]);
}//end transalte
}//end difference
}//end module


///////////////////////////
//lickingport();
//backpanel();
///////////////////////////
/*
translate([headportx/5+lickspoutoffset+tol,-headportwall,-(forcesensord+headportwall/2)]){
rotate([0,0,180]){
//fsensorholder();
needlesupport();
}//end rotate
}//end translate
*/

//
needlesupport();
