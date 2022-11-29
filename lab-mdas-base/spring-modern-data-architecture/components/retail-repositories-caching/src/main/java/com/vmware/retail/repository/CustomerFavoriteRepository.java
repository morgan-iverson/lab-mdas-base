package com.vmware.retail.repository;

import com.vmware.retail.domain.CustomerFavorites;
import org.springframework.data.keyvalue.repository.KeyValueRepository;
import org.springframework.stereotype.Repository;

/**
 * CustomerFavoriteSortedSetRepository
 *
 * @author Gregory Green
 */
@Repository
public interface CustomerFavoriteRepository extends KeyValueRepository<CustomerFavorites,String>
{
}