/**
 * Created by kristianeschenburg on 7/19/17.
 */

import java.io.IOException;
import java.util.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.HashSet;
import java.util.HashMap;
import niftijio.*;

/*
In order to add libraries, go to File > Project Structure > Moduldes > '+' Jar or
Dependencies. This will add the necessary .jar files to under External Libraries.

Then you can import the library by name. ex import niftijio.*;
/*
 */


public class voxelMapper {

    // List of arrays
    public static List<int[]> lookUpCoords;
    // Volume with indices mapping to voxel ROI values
    public static NiftiVolume labelVolume;
    // Volume with indices mapping to voxel coordinates
    public static NiftiVolume mappingVolume;

    // Constructor to load nifti volumes and read coordinates
    public voxelMapper(String coordinateFile, String label, String maps) throws
            IOException {

        lookUpCoords = readCoordinates(coordinateFile);
        labelVolume = NiftiVolume.read(label);
        mappingVolume = NiftiVolume.read(maps);

    }

    // Read individual lines from coordinate file, and add them to ArrayList
    private List<int[]> readCoordinates(String coordinates) throws
            FileNotFoundException {

        File file = new File(coordinates);
        Scanner wholeFile = new Scanner(file);

        List<int[]> coordList = new ArrayList<int[]>();

        while (wholeFile.hasNextLine()) {

            String line = wholeFile.nextLine();

            Scanner singleLine = new Scanner(line);

            int[] coords = new int[3];
            int c = 0;

            while (singleLine.hasNext()) {
                coords[c] = Integer.parseInt(singleLine.next());
                c++;
            }

            coordList.add(coords);
        }
        return coordList;
    }

    // Map voxel coordiantes to matrix indices
    // Matrix indices coorespond to unique integer values for each vertex.
    public HashMap<Integer, ArrayList<Integer>>  labelToCoordinateMaps() {

        HashMap<Integer,ArrayList<Integer>> labelMap = new HashMap<Integer,
                ArrayList<Integer>>();

        for (int[] voxel : lookUpCoords) {

            int x = voxel[0];
            int y = voxel[1];
            int z = voxel[2];

            int index = (int) mappingVolume.data.get(x,y,z,0);
            int label = (int) labelVolume.data.get(x,y,z,0);

            if (!labelMap.containsKey(label)) {
                ArrayList<Integer> temp = new ArrayList<Integer>();
                temp.add(index);
                labelMap.put(label,temp);
            } else {
                ArrayList<Integer> temp = labelMap.get(label);

                if (!labelMap.get(label).contains(index)) {
                    temp.add(index);
                    labelMap.put(label,temp);
                }
            }
        }

        for (int label : labelMap.keySet()) {
            System.out.println("Label: " + label + " Size: " + labelMap.get(label).size
                    ());
        }

        return labelMap;
    }
}
