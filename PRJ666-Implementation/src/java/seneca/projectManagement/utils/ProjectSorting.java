/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.utils;

import java.util.Comparator;
import seneca.projectManagement.entity.Projects;

/**
 *
 * @author KepneR
 */
public class ProjectSorting implements Comparator<Projects> {

    @Override
    public int compare(Projects o1, Projects o2) {
        return o1.getPrjName().compareTo(o2.getPrjName());
    }
    
}
