import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseIntPipe,
  Post,
  Put,
} from '@nestjs/common';

import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';

import { BrandsService } from './brands.service';
import { CreateBrandDto } from './dto/create-brand.dto';
import { UpdateBrandDto } from './dto/update-brand.dto';

@ApiTags('Brands')
@Controller('brands')
export class BrandsController {
  constructor(private readonly brandsService: BrandsService) {}

  @ApiOperation({
    summary: 'Create a new brand',
  })
  @ApiResponse({
    status: 201,
    description: 'Brand created successfully',
  })
  @Post()
  create(@Body() dto: CreateBrandDto) {
    return this.brandsService.create(dto);
  }

  @ApiOperation({
    summary: 'Get all brands',
  })
  @ApiResponse({
    status: 200,
    description: 'Return all brands',
  })
  @Get()
  findAll() {
    return this.brandsService.findAll();
  }

  @ApiOperation({
    summary: 'Get brand by ID',
  })
  @ApiResponse({
    status: 200,
    description: 'Return a brand',
  })
  @ApiResponse({
    status: 404,
    description: 'Brand not found',
  })
  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.brandsService.findOne(id);
  }

  @ApiOperation({
    summary: 'Update a brand',
  })
  @ApiResponse({
    status: 200,
    description: 'Brand updated successfully',
  })
  @ApiResponse({
    status: 404,
    description: 'Brand not found',
  })
  @Put(':id')
  update(@Param('id', ParseIntPipe) id: number, @Body() dto: UpdateBrandDto) {
    return this.brandsService.update(id, dto);
  }

  @ApiOperation({
    summary: 'Delete a brand',
  })
  @ApiResponse({
    status: 200,
    description: 'Brand deleted successfully',
  })
  @ApiResponse({
    status: 404,
    description: 'Brand not found',
  })
  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.brandsService.remove(id);
  }
}
