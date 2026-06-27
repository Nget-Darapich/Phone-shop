import { Injectable, NotFoundException } from '@nestjs/common';

import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

import { Brand } from './entities/brand.entity';
import { CreateBrandDto } from './dto/create-brand.dto';
import { UpdateBrandDto } from './dto/update-brand.dto';

@Injectable()
export class BrandsService {
  constructor(
    @InjectRepository(Brand)
    private readonly brandRepository: Repository<Brand>,
  ) {}

  async create(dto: CreateBrandDto) {
    const brand = this.brandRepository.create(dto);

    return await this.brandRepository.save(brand);
  }

  async findAll() {
    return await this.brandRepository.find({
      order: {
        id: 'ASC',
      },
    });
  }

  async findOne(id: number) {
    const brand = await this.brandRepository.findOne({
      where: { id },
    });

    if (!brand) {
      throw new NotFoundException('Brand not found');
    }

    return brand;
  }

  async update(id: number, dto: UpdateBrandDto) {
    const brand = await this.findOne(id);

    Object.assign(brand, dto);

    return await this.brandRepository.save(brand);
  }

  async remove(id: number) {
    const brand = await this.findOne(id);

    await this.brandRepository.remove(brand);

    return {
      message: 'Brand deleted successfully',
    };
  }
}
