/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.utils;

import java.util.Comparator;
import seneca.projectManagement.entity.Accounts;
/**
 *
 * @author KepneR
 */
public class AccountSorting implements Comparator<Accounts> {

    @Override
    public int compare(Accounts o1, Accounts o2) {
        return o1.getUserIdentifier().compareToIgnoreCase(o2.getUserIdentifier());
    }
    
}
