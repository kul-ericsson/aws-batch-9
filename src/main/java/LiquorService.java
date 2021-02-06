package com.sample;

import com.sample.model.LiquorType;

import java.util.ArrayList;
import java.util.List;

public class LiquorService {

    public List getAvailableBrands(LiquorType type){

        List brands = new ArrayList();

        if(type.equals(LiquorType.HARYANA)){
            brands.add("Faridabad");
            brands.add(("Gurugram"));

        }/*else if(type.equals(LiquorType.TAMILNADU)){
            brands.add("Chennai");
            brands.add("Mahabalipuram");

        }*/else if(type.equals(LiquorType.MAHARASHTRA)){
            brands.add("Mumbai");

        }else {
            brands.add("No Information Available");
        }
    return brands;
    }
}