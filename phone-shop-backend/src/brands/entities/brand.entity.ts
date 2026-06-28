import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';

@Entity('brands')
export class Brand {
  @ApiProperty()
  @PrimaryGeneratedColumn()
  id: number;

  @ApiProperty({
    example: 'Apple',
  })
  @Column({
    unique: true,
  })
  name: string;

  @ApiProperty({
    example: 'apple.png',
    required: false,
  })
  @Column({
    nullable: true,
  })
  logo: string;
}
